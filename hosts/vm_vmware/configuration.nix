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
    baseImageSize = 64 * 1024;

    vmFileName = "XVM_20220727_02.vmdk";
  };
}

