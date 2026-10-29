{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        jnoortheen.nix-ide
      ];
      userSettings = {
        "editor.inlayHints.enabled" = "off";
        "workbench.colorTheme" = "Dark Modern";
      };
      keybindings = [
        {
          key = "alt+left";
          command = "workbench.action.navigateBack";
        }
        {
          key = "alt+right";
          command = "workbench.action.navigateForward";
        }
      ];
    };
  };
}
