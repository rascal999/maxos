{

  #================================================
  #==================FLAKE-REPOS===================
  #================================================    

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

      #nix-gaming = {
  #     url = "github:fufexan/nix-gaming";
  #     inputs.nixpkgs.follows = "nixpkgs";
  #  };
  };

  outputs = inputs@{ nixpkgs, home-manager, agenix, ... }:
  let
    system = "x86_64-linux";

    lib = nixpkgs.lib;


  #================================================
  #==============FLAKE-CLASS-CONFIG================
  #================================================    

    minimalConfigSettings = [
      #agenix.nixosModule
      #./config/nur.nix
      ./config/pkgs_minimal.nix
      ./config/shared.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];

    configSettings = [
      agenix.nixosModules.default
      ./config/nur.nix
      #./config/electron_override.nix
      ./config/pkgs_minimal.nix
      ./config/shared.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];


  #================================================
  #===========INDIVIDUAL-FLAKE-CONFIG==============
  #================================================  



  in {
    nixosConfigurations = {
      ### RIG
      rig = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = configSettings ++ [
          ./config/docker.nix
          ./config/grub.nix
          ./config/pkgs_additional.nix
          ./config/pkgs_base.nix
          ./config/pkgs_ui.nix
          ./config/secrets.nix
          ./config/syncthing.nix
          ./hosts/rig/configuration.nix
          ./hosts/rig/hardware-configuration.nix

          ({ pkgs, ... }: {
            home-manager.users.user.imports = [
              ./hosts/rig/home.nix
              ./hosts/rig/i3/i3.nix
            ];
          })
        ];
      };  

      ### MAC
      mac = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = configSettings ++ [
          ./config/docker.nix
          ./config/grub.nix
          ./config/pkgs_additional.nix
          ./config/pkgs_base.nix
          ./config/pkgs_ui.nix
          #./config/secrets.nix
          #./config/syncthing.nix
          ./hosts/mac/configuration.nix
          ./hosts/mac/hardware-configuration.nix

          ({ pkgs, ... }: {
            home-manager.users.user.imports = [
              ./hosts/mac/home.nix
          ##    ./hosts/mac/i3/i3.nix
            ];
          })
        ];
      };
      
      ### PAV
      pav = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = configSettings ++ [
          ./config/grub.nix
          ./config/pkgs_minimal.nix
          ./config/pkgs_ui.nix
          ./hosts/pav/configuration.nix
          ./hosts/pav/hardware-configuration.nix

          ({ pkgs, ... }: {
            home-manager.users.user.imports = [
              ./config/i3-vars.nix
              ./home.nix
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
          ./config/pkgs_base.nix
          ./config/pkgs_ui.nix
          ./config/secrets.nix
          ./config/syncthing.nix
          ./hosts/rog/configuration.nix
          ./hosts/rog/hardware-configuration.nix

          ({ pkgs, ... }: {
            home-manager.users.user.imports = [
              ./config/i3-vars.nix
              ./hosts/rog/i3/i3.nix
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

      ### Minimal VM (VirtualBox)
      vm_virtualbox_minimal = lib.makeOverridable nixpkgs.lib.nixosSystem {
        inherit system;
        modules = minimalConfigSettings ++ [
          ./hosts/vm_virtualbox_minimal/configuration.nix
          ./config/pkgs_ui.nix

          ({ pkgs, ... }: {
            home-manager.users.user.imports = [
              ./home.nix
              ./hosts/vm_virtualbox/home.nix
            ];
          })
        ];
      };

      ### VM (VirtualBox)
      vm_virtualbox = lib.makeOverridable nixpkgs.lib.nixosSystem {
        inherit system;
        modules = configSettings ++ [
          ./hosts/vm_virtualbox/configuration.nix

          ({ pkgs, ... }: {
            home-manager.users.user.imports = [
              ./home.nix
              ./hosts/vm_virtualbox/home.nix
            ];
          })
        ];
      };

      ### VM (VMware)
      vm_vmware = lib.makeOverridable nixpkgs.lib.nixosSystem {
        inherit system;
        modules = configSettings ++ [
          ./config/docker.nix
          ./hosts/vm_vmware/configuration.nix

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
          ./config/pkgs_base.nix
          ./config/secrets.nix
          ./config/syncthing.nix
          ./hosts/blueboy/configuration.nix
          ./hosts/blueboy/dhcp.nix
          ./hosts/blueboy/docker.nix
          ./hosts/blueboy/ddclient.nix
          ./hosts/blueboy/hardware-configuration.nix
          ./hosts/blueboy/syncthing.nix

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
          ./config/pkgs_base.nix
          ./config/pkgs_ui.nix
          ./config/secrets.nix
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
