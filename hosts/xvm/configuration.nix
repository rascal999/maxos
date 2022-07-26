{ config, pkgs, lib, ... }:

{
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;

  networking.hostName = "xvm";

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

  # VM settings
  virtualbox = {
    #baseImageSize = 64 * 1024;

    extraDisk = {
      label = "docker";
      mountPoint = "/var/lib/docker";
      size = 200 * 1024;
    };

    memorySize = 4096;

    params = {
      audio = "none";
      audioin = "off";
      audioout = "off";
      cpus = "4";
      nic1 = "bridged";
      usbehci = "off";
    };

    vmFileName = "XVM_20220726_02.ova";
    vmName = "XVM";
  };
}
