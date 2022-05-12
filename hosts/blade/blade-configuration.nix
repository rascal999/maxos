{ config, pkgs, lib, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
}
