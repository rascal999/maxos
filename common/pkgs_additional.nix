{ config, pkgs, lib, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     android-studio
     libreoffice-fresh
     OVMF
     qemu
     qemu-utils
  ];
}
