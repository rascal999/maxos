{ config, pkgs, lib, ... }:

{
  networking.hostName = "maxos";

  # Override defaults
  #fonts.fontconfig.enable = lib.mkForce true;

  # VM settings
  virtualbox = {
    baseImageSize = 64 * 1024;

    memorySize = 2048;

    params = {
      audio = "none";
      audioin = "off";
      audioout = "off";
      cpus = "4";
      nic1 = "bridged";
      nictype1 = "virtio";
      usbehci = "off";
    };

    vmFileName = "maxos_minimal.ova";
    vmName = "maxos_minimal";
  };
}
