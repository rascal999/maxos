{ config, lib, pkgs, ... }:

{
  xresources.properties = {
    "urxvt.scrollBar" = "false";
    "urxvt.font" = "xft:MesloLGS Nerd Font Mono:pixelsize=22";
    "*background" = "#101010";
    "*foreground" = "#66FF66";
    "*cursorColor" = "#66ff66";
  };
}
