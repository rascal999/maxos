{ config, pkgs, lib, ... }: {
  services.syncthing = {
    enable = true;
    dataDir = "/home/user/syncthing";
    extraOptions = {
      gui = {
        theme = "black";
        tls = true;
      };
    };
    user = "user";
  };
}
