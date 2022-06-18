{ config, pkgs, lib, ... }: {
  services.syncthing.extraOptions = {
    address = "0.0.0.0:8384";
    gui = {
      theme = "black";
    };
  };
}
