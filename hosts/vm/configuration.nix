{ config, pkgs, lib, ... }:

{
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

  networking.hostName = "iso";

  # Override defaults
  fonts.fontconfig.enable = lib.mkForce true;
  services.xserver.resolutions = [
    {
      x = 1920; y = 1440;
    }
  ];
}
