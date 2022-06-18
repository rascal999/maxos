{ config, pkgs, lib, ... }: {
  services.syncthing = {
    enable = true;
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
