{  
  users.users.stefan = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
  home-manager.users.stefan = import ./home.nix;
}