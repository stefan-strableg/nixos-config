{ pkgs, ... }:

{
  home.packages = with pkgs; [
    docker
  ];

  users.users.stefan.extraGroups = [ "docker" ];
}
