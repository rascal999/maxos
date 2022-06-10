{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      blade = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./common/nur.nix
          ./shared.nix
          ./hosts/blade/blade-configuration.nix
          ./hosts/blade/blade-hw.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.user = import ./hosts/blade/blade-home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];

        #specialArgs = { inherit inputs; };
      };

      rig = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./common/nur.nix
          ./shared.nix
          ./hosts/rig/rig-configuration.nix
          ./hosts/rig/rig-hw.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.user = import ./hosts/rig/rig-home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];

        #specialArgs = { inherit inputs; };
      };

      rog = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./common/nur.nix
          ./shared.nix
          ./hosts/rog/rog-configuration.nix
          ./hosts/rog/rog-hw.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.user = import ./home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];

        #specialArgs = { inherit inputs; };
      };

      iso = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
          ./common/nur.nix
          ./shared.nix
          ./hosts/rog/rog-configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.user = import ./home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };
    };
  };
}
