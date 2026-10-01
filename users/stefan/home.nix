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
  ];

  home.shellAliases = {
    nxr = "sudo nixos-rebuild switch --flake ~/nixos-config#\$HOSTNAME";
    nxu = "nix flake update --flake ~/nixos-config";
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
}
