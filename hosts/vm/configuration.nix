{ config, pkgs, lib, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.useOSProber = true;

  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "nodev"; # or "nodev" for efi only
  boot.loader.grub.extraEntries = ''
    menuentry "Reboot" {
      reboot
    }
    menuentry "Poweroff" {
      halt
    }
  '';

  boot.kernelParams = [ "intel_pstate=active" ];
  boot.initrd.availableKernelModules = lib.optional config.boot.initrd.network.enable "virtio-pci";
  boot.initrd.network = {
    enable = true;
  };

  networking.hostName = "vm";
  networking.networkmanager.enable = true;
  # To allow networkmanager
  networking.wireless.enable = lib.mkForce false;

  # X11 / i3
  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;

    displayManager = {
      defaultSession = "none+i3";
      lightdm.enable = true;
      autoLogin.enable = true;
      autoLogin.user = "user";
    };
  };

  # Override defaults
  fonts.fontconfig.enable = lib.mkForce true;

  services.xserver.resolutions = [
    {
      x = 1920; y = 1440;
    }
  ];
}

