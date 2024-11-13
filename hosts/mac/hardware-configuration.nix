# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "ahci" "thunderbolt" "xhci_pci" "usbhid" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ]; #"kvm-amd"
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/ecb57bd8-b225-468c-b450-a7231a5e7774";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."root".device = "/dev/disk/by-uuid/0c01e360-b7aa-4d3a-9b86-495f9188f43f";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/47D8-B3D4";
      fsType = "vfat";
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.br-4cdaa2b21677.useDHCP = lib.mkDefault true;
  # networking.interfaces.br-6f85fe33535e.useDHCP = lib.mkDefault true;
  # networking.interfaces.br-d7c4a6a7c79a.useDHCP = lib.mkDefault true;
  # networking.interfaces.docker0.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;
  # networking.interfaces.veth02d0bb8.useDHCP = lib.mkDefault true;
  # networking.interfaces.veth0521405.useDHCP = lib.mkDefault true;
  # networking.interfaces.veth560233f.useDHCP = lib.mkDefault true;
  # networking.interfaces.veth5646f0f.useDHCP = lib.mkDefault true;
  # networking.interfaces.veth5a536db.useDHCP = lib.mkDefault true;
  # networking.interfaces.veth5fdcff0.useDHCP = lib.mkDefault true;
  # networking.interfaces.veth737bc7c.useDHCP = lib.mkDefault true;
  # networking.interfaces.veth864de3d.useDHCP = lib.mkDefault true;
  # networking.interfaces.veth8e4e067.useDHCP = lib.mkDefault true;
  # networking.interfaces.veth90eb5de.useDHCP = lib.mkDefault true;
  # networking.interfaces.veth9280487.useDHCP = lib.mkDefault true;
  # networking.interfaces.vetha2b9c7b.useDHCP = lib.mkDefault true;
  # networking.interfaces.vetha5798df.useDHCP = lib.mkDefault true;
  # networking.interfaces.vethae096bc.useDHCP = lib.mkDefault true;
  # networking.interfaces.vethc3bd056.useDHCP = lib.mkDefault true;
  # networking.interfaces.vethc626df1.useDHCP = lib.mkDefault true;
  # networking.interfaces.vethc9a540b.useDHCP = lib.mkDefault true;
  # networking.interfaces.vethcb13f96.useDHCP = lib.mkDefault true;
  # networking.interfaces.vethe84d059.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
