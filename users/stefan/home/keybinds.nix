{ pkgs, ...}:

{
  dconf.settings = {
      "org/gnome/desktop/wm/keybindings" = {
        switch-applications = [ ];
        switch-windows = [ "<Alt>Tab" ];
        switch-windows-backward = [ "<Alt><Shift>Tab" ];
      };
      
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

    "org/gnome/shell" = {
      favorite-apps = [];
    };
  };
}