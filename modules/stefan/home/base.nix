{ ... }:

{
  home.username = "stefan";
  home.homeDirectory = "/home/stefan";
  home.stateVersion = "26.05";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs.bash.enable = true;
  home.shellAliases = {
    nxr = "sudo nixos-rebuild switch --flake ~/nixos-config#\$HOSTNAME";
    nxu = "nix flake update --flake ~/nixos-config";
    nxd = "nix develop";
    nxc = "nix develop -c code .";
  };
}
