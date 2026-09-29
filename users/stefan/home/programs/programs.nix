{ pkgs, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user.name = "Stefan Strableg";
      user.email = "stefan@strableg.at";

      init.defaultBranch = "main";
    };
  };
  programs.bash.enable = true;

  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        jnoortheen.nix-ide
        llvm-vs-code-extensions.vscode-clangd
      ];
      userSettings = {
        "editor.inlayHints.enabled" = "off";
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

  programs.keepassxc = {
    enable = true;
    settings = {
      Browser = {
        Enabled = true;
      };
      SSHAgent = {
        Enabled = true;
      };
      General = {
        MinimizeAfterUnlock = true;
      };
    };
  };

  programs.firefox = {
    enable = true;
    profiles.default = {
      settings = {
        "extensions.autoDisableScopes" = 0;
      };
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
      ExtensionSettings = {
        "keepassxc-browser@keepassxc.org" = {
          installation_mode = "force_installed";
        };
      };

      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
    };
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      "*" = {
        IdentityFile = "~/secrets/shared_key";
        AddKeysToAgent = "yes";
      };
    };
  };

  programs.obsidian = {
    enable = true;
    cli.enable = true;
  };

}