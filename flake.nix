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

  outputs = inputs@{ nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";

    commonModules = [
      ./common/nur.nix
      ./common/shared.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;

        # Optionally, use home-manager.extraSpecialArgs to pass
        # arguments to home.nix
      }
    ];
  in {
    nixosConfigurations = {
      ### BLADE
      blade = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = commonModules ++ [
          ./hosts/blade/configuration.nix
          ./hosts/blade/hardware.nix

          ({ pkgs, ... }: {
            home-manager.users.user.imports = [
              ./common/i3-vars.nix
              ./home.nix
              ./hosts/blade/home.nix
            ];
          })
        ];
      };

      ### RIG
      rig = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = commonModules ++ [
          ./hosts/rig/configuration.nix
          ./hosts/rig/hardware.nix

          ({ pkgs, ... }: {
            home-manager.users.user.imports = [
              ./home.nix
              ./hosts/rig/i3/i3.nix
            ];
          })
        ];
      };

      ### ROG
      rog = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = commonModules ++ [
          ./hosts/rog/configuration.nix
          ./hosts/rog/hardware.nix

          ({ pkgs, ... }: {
            home-manager.users.user.imports = [
              ./home.nix
              ./common/i3-vars.nix
            ];
          })
        ];
      };

      ### ISO
      iso = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./common/nur.nix
          ./common/shared.nix
          ./hosts/iso/configuration.nix
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.user.imports = [
              ./home.nix
              ./common/i3-vars.nix
            ];
            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };
    };
  };
}
