{ config, pkgs, lib, ... }: {
  services.syncthing.enable = true;
  services.syncthing.guiAddress = "0.0.0.0:8384";
}
