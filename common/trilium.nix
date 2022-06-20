{ config, pkgs, lib, ... }: {
  services.trilium-server = {
    enable = true;
    dataDir = "/home/user/trilium";
    host = "127.0.0.1";
    port = 9020;
  };
}
