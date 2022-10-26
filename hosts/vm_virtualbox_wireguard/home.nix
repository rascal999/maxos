{ config, pkgs, ... }:

{
  home.file.".kde/share/config/kdeglobals".source = ../../config/kdeglobals;
  home.file.".kde/share/config/kscreensaverrc".source = ../../config/kscreensaverrc;
}
