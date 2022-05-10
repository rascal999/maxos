{ config, lib, pkgs, ... }:

{
  xresources.properties = {
    "urxvt.scrollBar" = "false";
    "*background" = "#101010";
    "*foreground" = "#66FF66";
    "*cursorColor" = "#66ff66";
  };
}
