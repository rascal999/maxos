{ config, pkgs, lib, ... }:

{
  networking.hostName = "blueboy";
  networking.interfaces.eno1.ipv4.addresses = [ {
    address = "192.168.0.10";
    prefixLength = 24;
  }];

  networking.defaultGateway = "192.168.1.1";
  networking.nameservers = [ "8.8.8.8" ];

  #services.xserver.videoDrivers = [ "nvidia" ];
  virtualisation.docker.enableNvidia = true;

  # X11 / i3
  services.xserver = {
    enable = false;
    windowManager.i3.enable = false;

    #displayManager = {
    #  defaultSession = "none+i3";
    #  lightdm.enable = true;
    #  autoLogin.enable = true;
    #  autoLogin.user = "user";
    #};
  };
}
