{ pkgs, ... }:

{
  home-manager.users.stefan = {
    home.packages = with pkgs; [
      clang
      clang-tools
    ];

    programs.vscode.profiles.default.extensions = with pkgs.vscode-extensions; [
      llvm-vs-code-extensions.vscode-clangd
    ];
  };
}
