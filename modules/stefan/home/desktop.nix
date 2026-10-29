{ ... }:

{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
    };
  };

  xdg.autostart.enable = true;

  # Fix KeePassXC launching in background on gnome
  home.packages = [
    qgnomeplatform
  ];
  xdg.desktopEntries."org.keepassxc.KeePassXC" = {
    name = "KeePassXC";
    comment = "Password Manager";
    exec = "env QT_QPA_PLATFORM=wayland QT_QPA_PLATFORMTHEME=gnome keepassxc %f";
    icon = "keepassxc";
    terminal = false;
    categories = [ "Utility" ];
    mimeType = [ "application/x-keepass2" ];
  };
}
