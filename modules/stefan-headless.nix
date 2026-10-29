{ ... }:

{
  imports = [
    ./stefan/networking.nix
    ./stefan/user.nix
  ];

  home-manager.users.stefan = {
    imports = [
      ./stefan/home/base.nix
      ./stefan/home/keybinds.nix
      ./stefan/home/packages.nix
      ./stefan/home/development/cpp.nix
      ./stefan/home/desktop.nix
      ./stefan/home/programs/git.nix
      ./stefan/home/programs/vscode.nix
      ./stefan/home/programs/firefox.nix
      ./stefan/home/programs/keepassxc.nix
      ./stefan/home/programs/obsidian.nix
      ./stefan/home/programs/ssh.nix
      ./stefan/home/services/ssh-agent.nix
      ./stefan/home/services/syncthing.nix
    ];
  };
}
