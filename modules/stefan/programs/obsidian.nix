{ ... }:

{
  home-manager.users.stefan = {
    programs.obsidian = {
      enable = true;
      cli.enable = true;
    };
  };
}
