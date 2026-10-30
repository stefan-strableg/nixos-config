{ pkgs, ... }:

{
  home-manager.users.stefan = {
    home.packages = with pkgs; [
      docker
    ];
    programs.vscode.profiles.default.extensions = with pkgs.vscode-extensions; [
      ms-azuretools.vscode-docker
      ms-vscode-remote.remote-containers
    ];
  };

  users.users.stefan.extraGroups = [ "docker" ];
  virtualisation.docker.enable = true;
}
