{ config, pkgs, lib, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    android-studio
    arduino                                                                                              # Basic Octave implementation of the matlab arduino extension, allowing communication to a programmed arduino board to control its hardware
    ghidra-bin
    libreoffice-fresh
    linuxKernel.packages.linux_5_15.vmware
    OVMF
    qemu
    qemu-utils
    vmware-horizon-client                                                                                # Allows you to connect to your VMware Horizon virtual desktop
    zoom-us                                                                                              # zoom.us video conferencing application
  ];
}
