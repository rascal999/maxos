{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.maxos.tools.dislocker;
in {
  options.maxos.tools.dislocker = {
    enable = mkEnableOption "dislocker — read access to BitLocker-encrypted volumes (useful on dual-boot hosts)";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      dislocker
      ntfs3g
    ];
  };
}