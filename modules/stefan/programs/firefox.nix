{ pkgs, ... }:

{
  home-manager.users.stefan = {
    programs.firefox = {
      enable = true;
      profiles.default = {
        settings."extensions.autoDisableScopes" = 0;
        extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
          keepassxc-browser
          adnauseam
        ];
        bookmarks = {
          force = true;
          settings = [
            {
              name = "Nix";
              toolbar = true;
              bookmarks = [
                {
                  name = "NixOS Search";
                  url = "https://search.nixos.org";
                }
              ];
            }
          ];
        };
      };

      policies = {
        ExtensionSettings."keepassxc-browser@keepassxc.org" = {
          installation_mode = "force_installed";
        };
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";
      };
    };
  };
}
