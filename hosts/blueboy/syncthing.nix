{ config, pkgs, lib, ... }: {
  services.syncthing.extraOptions = {
    gui = {
      address = "0.0.0.0:8384";
      theme = "black";
    };
  };
}
