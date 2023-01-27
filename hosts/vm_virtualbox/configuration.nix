{ config, pkgs, lib, ... }:

{
  networking.hostName = "maxos";

  # X11 / plasma
  services.xserver = {
    enable = true;
    desktopManager.plasma5.enable = true;
    windowManager.i3.enable = true;

    displayManager = {
      defaultSession = "plasma";
      lightdm.enable = true;
      #autoLogin.enable = true;
      #autoLogin.user = "user";
    };
  };

  # Override defaults
  fonts.fontconfig.enable = lib.mkForce true;

  services.xserver.resolutions = [
    {
      x = 1920; y = 1440;
    }
  ];

  # For https://github.com/NixOS/nixpkgs/issues/59867
  systemd.services.docker.serviceConfig.ExecStart = [
    ""
    "${pkgs.docker}/bin/dockerd -g /home/user/maxos/docker -H fd://"
  ];

  # Password for user
  users.users.user.password = "password";

  # VM settings
  virtualbox = {
    baseImageSize = 64 * 1024;

    extraDisk = {
      label = "home";
      mountPoint = "/home/user/maxos";
      size = 512 * 1024;
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
