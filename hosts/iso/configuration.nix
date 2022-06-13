{ config, pkgs, lib, ... }:

{
  networking.hostName = "iso";
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

