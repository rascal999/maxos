{ config, pkgs, lib, ... }:

{
  networking.hostName = "maxos";

  # Override defaults
  #fonts.fontconfig.enable = lib.mkForce true;

  # Authorised keys
  users.users.user = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBEHhsgw+RqLwv8HjBuC5hNpfc+KTBUypsK8yw1Ay4XP user@rig"
    ];
  };

  # VM settings
  virtualbox = {
    baseImageSize = 64 * 1024;

    memorySize = 2048;

    params = {
      audio = "none";
      audioin = "off";
      audioout = "off";
      cpus = "4";
      nic1 = "nat";
      nictype1 = "virtio";
      #nic1 = "bridged";
      #nictype1 = "virtio";
      usbehci = "off";
    };

    vmFileName = "maxos_minimal.ova";
    vmName = "maxos_minimal";
  };
}
