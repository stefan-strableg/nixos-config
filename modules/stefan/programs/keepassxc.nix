{ ... }:

{
  home-manager.users.stefan = {
    programs.keepassxc = {
      enable = true;
      settings = {
        GUI = {
          ShowTrayIcon = true;
          MinimizeOnClose = true;
          MinimizeToTray = true;
          LaunchAtStartup = true;
        };
        Browser.Enabled = true;
        SSHAgent.Enabled = true;
        Security = {
          LockDatabaseIdle = false;
          LockDatabaseScreenLock = false;
        };
      };
    };
  };
}
