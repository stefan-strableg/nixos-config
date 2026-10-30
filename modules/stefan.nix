{ ... }:

{
  imports = [
    ./stefan/networking.nix
    ./stefan/user.nix
    ./stefan/base.nix
    ./stefan/keybinds.nix
    ./stefan/packages.nix
    ./stefan/development/cpp.nix
    ./stefan/desktop.nix
    ./stefan/programs/git.nix
    ./stefan/programs/vscode.nix
    ./stefan/programs/firefox.nix
    ./stefan/programs/keepassxc.nix
    ./stefan/programs/obsidian.nix
    ./stefan/programs/docker.nix
    ./stefan/programs/ssh.nix
    ./stefan/services/ssh-agent.nix
    ./stefan/services/syncthing.nix
  ];
}
