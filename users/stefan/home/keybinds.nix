{ pkgs, ...}:

{
  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/nix-config/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/nix-config" = {
      name = "Open NixOS Config Folder in VSCode";
      command = "code /home/stefan/nixos-config";
      binding = "<Super>x";
    };
  };
}