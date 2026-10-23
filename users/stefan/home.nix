{ pkgs, ... }:

{
  imports = [
    ./home/keybinds.nix
    ./home/programs/programs.nix
    ./home/services/services.nix
  ];

  home.username = "stefan";
  home.homeDirectory = "/home/stefan";

  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    git
    curl
    wget
    ripgrep
    fd
    tree
    bash
    jq
    gimp
    nmap
    netcat
    clang
    clang-tools
    htop
    openconnect
    gti
    sl
    nixfmt
    qgnomeplatform
  ];

  home.shellAliases = {
    nxr = "sudo nixos-rebuild switch --flake ~/nixos-config#\$HOSTNAME";
    nxu = "nix flake update --flake ~/nixos-config";
    nxd = "nix develop";
    nxc = "nix develop -c code .";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
    };
  };

  xdg.autostart.enable = true;

  xdg.desktopEntries."org.keepassxc.KeePassXC" = {
    name = "KeePassXC";
    comment = "Password Manager";
    exec = "env QT_QPA_PLATFORM=wayland QT_QPA_PLATFORMTHEME=gnome keepassxc %f";
    icon = "keepassxc";
    terminal = false;
    categories = [ "Utility" ];
    mimeType = [ "application/x-keepass2" ];
  };
}
