{pkgs, ...} :
{  
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-openconnect
    ];
    ensureProfiles.profiles.eduroam = {
      connection = {
        id = "eduroam";
        type = "wifi";
      };

      wifi = {
        ssid = "eduroam";
      };

      wifi-security = {
        key-mgmt = "wpa-eap";
      };

      "802-1x" = {
        eap = "peap";
        identity = "xx8357@tugraz.at";
        anonymous-identity = "anonymous@tugraz.at";
        phase2-auth = "mschapv2";
      };
    };
  };
  users.users.stefan = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
  home-manager.users.stefan = import ./home.nix;
}