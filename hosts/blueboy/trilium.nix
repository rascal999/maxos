{ config, pkgs, lib, ... }: {
  services.trilium-server = {
    enable = true;
    host = "0.0.0.0";
  };
}
