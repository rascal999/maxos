{ config, pkgs, lib, ... }: {
  services.trilium-server = {
    enable = true;
    port = 9020;
  };
}
