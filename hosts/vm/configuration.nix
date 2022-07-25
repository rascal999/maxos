{ config, pkgs, lib, ... }:

{
  networking.hostName = "vm";

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
    baseImageFreeSpace = 64 * 1024;
    memorySize = 4096;

    params = {
      audio = "none";
      audioin = "off";
      audioout = "off";
      cpus = "4";
      nic1 = "bridged";
      usbehci = "off";
    };

    vmFileName = "XVM_20220725_01";
    vmName = "XVM";
  };
}

