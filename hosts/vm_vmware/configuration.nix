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
  vmware = {
    baseImageSize = 200 * 1024;

    memorySize = 8192;

    vmFileName = "XVM_20220727_01.vmdk";
    vmName = "XVM";
  };
}

