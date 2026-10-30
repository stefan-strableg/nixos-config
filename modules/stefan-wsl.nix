{ ... }:

{
  imports = [
    ./stefan/user.nix
    ./stefan/base.nix
    ./stefan/packages.nix
    ./stefan/development/cpp.nix
    ./stefan/programs/git.nix
    ./stefan/programs/vscode.nix
    ./stefan/programs/ssh.nix
    ./stefan/services/syncthing.nix
  ];
}
