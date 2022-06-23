{ config, pkgs, lib, ... }:

{
  networking.hostName = "galaxy";

  services.xserver.videoDrivers = [ "intel" ];

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
}
