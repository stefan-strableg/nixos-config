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

  outputs = inputs@{ nixpkgs, home-manager, nur, ... }: {
    nixosConfigurations = {
      thinks = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./configuration.nix

          {
            nixpkgs.overlays = [
              nur.overlays.default
            ];
          }

          home-manager.nixosModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.stefan = import ./home.nix;

            home-manager.extraSpecialArgs = { 
              inherit inputs;
            };
          }
        ];
      };
      # pc = nixpkgs.lib.nixosSystem {
      #   system = "x86_64-linux";

      #   modules = [
      #     ./configuration.nix

      #     home-manager.nixosModules.home-manager

      #     {
      #       home-manager.useGlobalPkgs = true;
      #       home-manager.useUserPackages = true;

      #       home-manager.users.stefan = import ./home.nix;
      #     }
      #   ];
      # };
    };
  };
}
