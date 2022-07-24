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

    lib = nixpkgs.lib;

    configSettings = [
      agenix.nixosModule
      ./config/nur.nix
      ./config/pkgs_base.nix
      ./config/shared.nix
      ./config/trilium.nix

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
        modules = configSettings ++ [
          ./config/docker.nix
          ./config/grub.nix
          ./config/pkgs_additional.nix
          ./hosts/blade/configuration.nix
          ./hosts/blade/hardware-configuration.nix

          ({ pkgs, ... }: {
            home-manager.users.user.imports = [
              ./config/i3-vars.nix
              ./home.nix
              ./hosts/blade/home.nix
            ];
          })
        ];
      };

      ### RIG
      rig = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = configSettings ++ [
          ./config/docker.nix
          ./config/grub.nix
          ./config/pkgs_additional.nix
          ./config/syncthing.nix
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
        modules = configSettings ++ [
          ./config/docker.nix
          ./config/grub.nix
          ./config/pkgs_additional.nix
          ./config/syncthing.nix
          ./hosts/rog/configuration.nix
          ./hosts/rog/hardware-configuration.nix

          ({ pkgs, ... }: {
            home-manager.users.user.imports = [
              ./config/i3-vars.nix
              ./home.nix
            ];
          })
        ];
      };

      ### ISO
      iso = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = configSettings ++ [
          ./hosts/iso/configuration.nix
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"

          ({ pkgs, ... }: {
            home-manager.users.user.imports = [
              ./config/i3-vars.nix
              ./home.nix
            ];
          })
        ];
      };

      ### VM
      vm = lib.makeOverridable nixpkgs.lib.nixosSystem {
        inherit system;
        modules = configSettings ++ [
          ./config/docker.nix
          ./config/pkgs_additional.nix
          ./hosts/vm/configuration.nix

          ({ pkgs, ... }: {
            home-manager.users.user.imports = [
              ./config/i3-vars.nix
              ./home.nix
            ];
          })
        ];
      };

      ### BLUEBOY
      blueboy = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = configSettings ++ [
          ./config/grub.nix
          ./config/pkgs_additional.nix
          ./config/syncthing.nix
          ./hosts/blueboy/configuration.nix
          ./hosts/blueboy/dhcp.nix
          ./hosts/blueboy/docker.nix
          ./hosts/blueboy/ddclient.nix
          ./hosts/blueboy/hardware-configuration.nix
          ./hosts/blueboy/syncthing.nix
          ./hosts/blueboy/trilium.nix
          ./hosts/blueboy/wireguard.nix

          ({ pkgs, ... }: {
            home-manager.users.user.imports = [
              ./config/i3-vars.nix
              ./home.nix
            ];
          })
        ];
      };

      ### GALAXY
      galaxy = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = configSettings ++ [
          ./config/grub.nix
          ./config/pkgs_additional.nix
          ./config/syncthing.nix
          ./hosts/galaxy/configuration.nix
          ./hosts/galaxy/hardware-configuration.nix

          ({ pkgs, ... }: {
            home-manager.users.user.imports = [
              ./config/i3-vars.nix
              ./home.nix
            ];
          })
        ];
      };
    };
  };
}
