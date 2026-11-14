{ lib, ... }:

{

  environment.variables = {
    NXCONFIG = lib.mkDefault (toString /home/stefan/nixos-config);
    NXCONFIG_STORE = toString ../..;
  };

  home-manager.users.stefan = {
    home.username = "stefan";
    home.homeDirectory = "/home/stefan";
    home.stateVersion = "26.05";

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    programs.bash.enable = true;
    home.shellAliases = {
      nxr = "sudo nixos-rebuild switch --flake \$NXCONFIG#\$HOSTNAME";
      nxu = "nix flake update --flake \$NXCONFIG";
      nxd = "nix develop";
      nxc = "bash \$NXCONFIG_STORE/scripts/vscode-auto.sh";
      nxe = "code \$NXCONFIG";
    };
  };
}
