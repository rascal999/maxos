{ config, pkgs, lib, ... }:

{
  hardware.opengl.driSupport32Bit = true;
  networking.hostName = "rig";
  services.xserver.videoDrivers = [ "nvidia" ];
  virtualisation.docker.enableNvidia = true;
}
