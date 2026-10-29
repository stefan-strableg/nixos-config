{ pkgs, ... }:

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

      wifi.ssid = "eduroam";

      wifi-security.key-mgmt = "wpa-eap";

      "802-1x" = {
        eap = "peap";
        identity = "xx8357@tugraz.at";
        anonymous-identity = "anonymous@tugraz.at";
        phase2-auth = "mschapv2";
      };
    };

    # Replace the gateway with your VPN endpoint before using this profile.
    # Credentials are intentionally not stored in the Nix configuration.
    ensureProfiles.profiles.openconnect-example = {
      connection = {
        id = "OpenConnect example";
        type = "vpn";
        autoconnect = false;
      };

      vpn = {
        service-type = "org.freedesktop.NetworkManager.openconnect";
        data = {
          gateway = "vpn.tugraz.at";
          protocol = "anyconnect";
          username = "xx8357";
        };
      };
    };
  };
}
