{ ... }:

{
  home-manager.users.stefan = {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
    };
  };
}
