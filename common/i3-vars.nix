{ config, lib, pkgs, ... }:

{
  xsession.windowManager.i3 = {
    config = {
      defaultWorkspace = "workspace number 1";

      startup = [
        {
          command = "exec ${pkgs.redshift}/bin/redshift -O 1900";
          notification = false;
        }
        {
          command = "exec ${pkgs.xorg.setxkbmap}/bin/setxkbmap dvorak";
          always = true;
          notification = false;
        }
        {
          command = "exec ${pkgs.firefox}/bin/firefox";
          workspace = "1";
        }
      ];
    };
  };
}
