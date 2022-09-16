{ config, pkgs, lib, ... }:

{
  networking.hostName = "maxos";

  # X11 / plasma
  services.xserver = {
    enable = true;
    desktopManager.plasma5.enable = true;

    displayManager = {
      defaultSession = "plasma";
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

  # VM settings
  virtualbox = {
    baseImageSize = 64 * 1024;

    extraDisk = {
      label = "docker";
      mountPoint = "/var/lib/docker";
      size = 128 * 1024;
    };

    memorySize = 8192;

    params = {
      audio = "none";
      audioin = "off";
      audioout = "off";
      cpus = "4";
      nic1 = "bridged";
      nictype1 = "virtio";
      usbehci = "off";
    };

    vmFileName = "maxos.ova";
    vmName = "maxos";
  };
}
