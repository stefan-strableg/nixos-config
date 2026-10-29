{ ... }:

{
  imports = [
    ./stefan/user.nix
  ];

  home-manager.users.stefan = {
    imports = [
      ./stefan/home/base.nix
      ./stefan/home/packages.nix
      ./stefan/home/development/cpp.nix
      ./stefan/home/programs/git.nix
      ./stefan/home/programs/vscode.nix
      ./stefan/home/programs/ssh.nix
      ./stefan/home/services/syncthing.nix
    ];
  };
}
