{
  description = "NixOS configuration";

  inputs = {
    agenix.url = "github:ryantm/agenix";

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

  outputs = inputs@{ nixpkgs, home-manager, agenix, ... }:
  let
    system = "x86_64-linux";

    commonSettings = [
      agenix.nixosModule
      ./common/docker.nix
      ./common/nur.nix
      ./common/shared.nix
      ./common/syncthing.nix
      ./common/trilium.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  in {
    nixosConfigurations = {
      ### BLADE
      blade = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = commonSettings ++ [
          ./hosts/blade/configuration.nix
          ./hosts/blade/hardware-configuration.nix

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
        modules = commonSettings ++ [
          ./hosts/rig/configuration.nix
          ./hosts/rig/hardware-configuration.nix

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
        modules = commonSettings ++ [
          ./hosts/rog/configuration.nix
          ./hosts/rog/hardware-configuration.nix

          ({ pkgs, ... }: {
            home-manager.users.user.imports = [
              ./common/i3-vars.nix
              ./home.nix
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

          ({ pkgs, ... }: {
            home-manager.users.user.imports = [
              ./common/i3-vars.nix
              ./home.nix
            ];
          })
        ];
      };

      ### VM
      vm = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = commonSettings ++ [
          ./hosts/vm/configuration.nix
          ./hosts/vm/hardware-configuration.nix

          ({ pkgs, ... }: {
            home-manager.users.user.imports = [
              ./common/i3-vars.nix
              ./home.nix
            ];
          })
        ];
      };

      ### BLUEBOY
      blueboy = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = commonSettings ++ [
          ./hosts/blueboy/configuration.nix
          ./hosts/blueboy/ddclient.nix
          ./hosts/blueboy/hardware-configuration.nix
          ./hosts/blueboy/trilium.nix
          ./hosts/blueboy/syncthing.nix
          ./hosts/blueboy/wireguard.nix

          ({ pkgs, ... }: {
            home-manager.users.user.imports = [
              ./common/i3-vars.nix
              ./home.nix
            ];
          })
        ];
      };
    };
  };
}
