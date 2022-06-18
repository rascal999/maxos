{ config, pkgs, lib, ... }: {
  services.syncthing = {
    dataDir = "/home/user/syncthing";
    guiAddress = "0.0.0.0:8384";
    extraOptions = {
      gui = {
        theme = "black";
        tls = true;
      };
    };
    user = "user";
  };
}
