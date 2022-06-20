{ config, pkgs, lib, ... }: {
  services.trilium-server = {
    enable = true;
    host = "127.0.0.1";
    port = 9020;
  };
}
