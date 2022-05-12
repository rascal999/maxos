{ config, pkgs, lib, ... }:

{
  services.xserver.videoDrivers = "nvidia";
}
