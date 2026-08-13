{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }:
  let
    mkHost = modules:
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          inherit inputs;
        };

        modules = modules;
      };
  in
  {
    nixosConfigurations = {
      thinks = mkHost [
        ./hosts/thinks/configuration.nix
        ./users/stefan/configuration.nix

        ./modules/home-manager.nix
        ./modules/nur.nix
      ];

      # pc = mkHost [
      #   ./hosts/pc/configuration.nix
      #   ./users/stefan/configuration.nix
      # ];
    };
  };
}
