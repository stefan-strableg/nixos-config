{ pkgs, ... }:

{
  home-manager.users.stefan = {
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
      htop
      openconnect
      gti
      sl
      nixfmt
      nixd
    ];
  };
}
