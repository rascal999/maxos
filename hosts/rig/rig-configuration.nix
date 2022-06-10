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

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.scanRandMacAddress = false;

  hardware.opengl.driSupport32Bit = true;
  networking.hostName = "rig";
  services.xserver.videoDrivers = [ "nvidia" ];

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

  services.xserver = {
    # Touchpad
    synaptics = {
      enable = true;
      vertTwoFingerScroll = true;
      palmDetect = true;
      minSpeed = "1.5";
    };
  };

  virtualisation.docker.enableNvidia = true;

  # Enable cron service
  services.cron = {
    enable = true;
    systemCronJobs = [
      "45 15 * * *        user    ${pkgs.rsync}/bin/rsync -avz --no-perms /home/user/Data/ admin@192.168.0.254:/volume1/k8s-syncthing-data/data/"
      "0 16 * * *        user    ${pkgs.rsync}/bin/rsync -avz --no-perms /home/user/Camera/Camera admin@192.168.0.254:/volume1/k8s-syncthing-data/camera/"
    ];
  };
}
