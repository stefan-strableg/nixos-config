{ pkgs, ... }:

{
  imports = [
    ./keybinds.nix
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
  ];

  home.shellAliases = {
    nxr = "sudo nixos-rebuild switch --flake ~/nixos-config#\$HOSTNAME";
    nxu = "nix flake update --flake ~/nixos-config";
    nxs = "firefox 'https://search.nixos.org' 'https://home-manager-options.extranix.com'";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
      ];
    };
  };

  programs.keepassxc = {
    enable = true;
    settings = {
      Browser = {
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

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
    };
  };

  services.ssh-agent = {
    enable = true;
  };

  services.syncthing = {
    enable = true;
    settings = {
      devices = {
        homes = {
          id = "T5BKMJ7-HDWMNUI-DYP7VR6-QKW4456-7CIB5FJ-KU3NRTB-O7EPYD2-7AABJAH";
        };
        s24s = {
          id = "OS672XH-TUBGY6O-FHCDXXJ-DZJDMJB-JKIO5UM-O63CLBD-LDSX46K-PE5PWQC";
        };
      };
      folders = {
        secrets = {
          id = "secrets";
          enable = true;
          devices = [ "homes" "s24s" ];
          path = "~/secrets";
        };
        obsidian-vault = {
          id = "obsidian-vault";
          enable = true;
          devices = [ "homes" "s24s" ];
          path = "~/obsidian-vault";
        };
        working-directory = {
          id = "working-directory";
          enable = true;
          devices = [ "homes" "s24s" ];
          path = "~/working-directory";
        };
      };
    };
  };


}
