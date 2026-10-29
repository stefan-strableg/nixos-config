{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";
  };

  outputs =
    inputs@{
      nixpkgs,
      nixos-wsl,
      home-manager,
      ...
    }:
    let
      mkHost =
        modules:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          specialArgs = {
            inherit inputs;
          };

          modules = modules ++ [ { nixpkgs.config.allowUnfree = true; } ];
        };
    in
    {
      nixosConfigurations = {
        thinks = mkHost [
          ./hosts/thinks/configuration.nix
          ./modules/stefan.nix

          ./modules/home-manager.nix
          ./modules/nur.nix
        ];

        wsl = mkHost [
          nixos-wsl.nixosModules.default

          ./hosts/wsl/configuration.nix
          ./modules/stefan-wsl.nix

          ./modules/home-manager.nix
          ./modules/nur.nix
        ];
      };
    };
}
