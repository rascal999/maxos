{ config, pkgs, lib, ... }: {
  services.syncthing = {
    guiAddress = "0.0.0.0:8384";
  };
}
