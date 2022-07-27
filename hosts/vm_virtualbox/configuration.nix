{ config, pkgs, lib, ... }:

{
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

    vmFileName = "XVM_20220726_04.ova";
    vmName = "XVM";
  };
}
