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
    ensureProfiles.profiles.tugraz = {
      connection = {
        id = "TU Graz VPN";
        type = "vpn";
        autoconnect = false;
      };

      vpn = {
        service-type = "org.freedesktop.NetworkManager.openconnect";
        gateway = "vpn.tugraz.at";
        protocol = "anyconnect";
        username = "xx8357";
        useragent = "AnyConnect";
        authtype = "password";
      };

      vpn-secrets = {
        # If no dummy password is provided, nm will attempt to
        # contact a nonexistent secret agent and fail
        password = "dummy";
      };
    };

  };
}
