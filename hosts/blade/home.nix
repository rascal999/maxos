{ config, pkgs, ... }:

{
  home.file.".kde/share/config/kdeglobals".source = ../../configs/kdeglobals;
}
