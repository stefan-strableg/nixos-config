{
  description = "General Template Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      # To Allow Unfree Packages:
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      # To Install VSCode with Extensions:
      vscode = pkgs.vscode-with-extensions.override {
        vscodeExtensions =
          with pkgs.vscode-extensions;
          [
            # Officially Packaged Extensions from Nixpkgs:
            vscjava.vscode-java-pack
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            # Custom packaged extensions from the VSCode Marketplace:
            {
              publisher = "vmware";
              name = "vscode-spring-boot";
              version = "2.5.2026100619";
              sha256 = "sha256-hFvssG4OqSGO3Vg83m4VPikfsWC5KV/yAYWCFCzbgBE=";
            }
            {
              publisher = "vscjava";
              name = "vscode-lombok";
              version = "1.1.2024071804";
              sha256 = "sha256-Vad2Jl0LqyzcaTq+VsLtuu55qlgNApFDYkrdSzSa94I=";
            }
          ];
      };
      # To Wrap Clangd to Use GCC as a Query Driver:
      # (Required for using Clangd with Projects that use GCC)
      gccClangdWrapper = pkgs.writeShellScriptBin "clangd" ''
        exec ${pkgs.clang-tools}/bin/clangd \
          --query-driver=${pkgs.gcc}/bin/gcc,${pkgs.gcc}/bin/g++ "$@"
      '';
      # Python packages to be installed in the devShell:
      python = pkgs.python3.withPackages (ps: [
        ps.duckdb
        ps.gitpython
        ps.pandas
        ps.plotly
        ps.streamlit
        ps.tqdm
      ]);
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        name = "dev-shell";

        buildInputs = with pkgs; [
          # C/C++ development:
          vscode
          gccClangdWrapper
          bash
          gcc
          gnumake
          git
          python3
          p7zip
          clang
          clang-tools
          gdb
          lldb
          bear
          valgrind
          cmake

          # Java Development:
          java
          maven
          git
          curl
          docker-client
          vscode
        ];

        shellHook = ''
          # Add the Clangd Wrapper
          export PATH=${gccClangdWrapper}/bin:$PATH
          # Load Environment Variables from .envrc if it exists
          if [ -f .envrc ]; then
            set -a
            source .envrc
            set +a
          fi
          echo "Nix Development Shell started successfully."
        '';
      };
    };
}
