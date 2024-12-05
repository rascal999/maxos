{ config, pkgs, lib, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_6_11;
  
  # Use the GRUB 2 boot loader.
  #boot.loader.grub.enable = true;
  #boot.loader.grub.efiSupport = true;
  #boot.loader.grub.efiInstallAsRemovable = true;
  #boot.loader.grub.useOSProber = true;
  #boot.loader.timeout = 120;

        # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.editor = true;
  boot.loader.systemd-boot.configurationLimit = 120;
  boot.loader.efi.canTouchEfiVariables = true;

  # Define on which hard drive you want to install Grub.
  #boot.loader.grub.device = "nodev"; # or "nodev" for efi only
  #boot.loader.grub.extraEntries = ''
  #  menuentry "Reboot" {
  #    reboot
  #  }
  #  menuentry "Poweroff" {
  #    halt
  #  }
  #'';
}
