{ config, lib, pkgs, ... }:

{
  xsession.windowManager.i3 = {
    config = {
      defaultWorkspace = "workspace number 2";

      startup = [
        {
          command = "exec ${pkgs.copyq}/bin/copyq";
        }
        {
          command = "exec ${../../../scripts/monitors.sh}";
        }
        {
          command = "exec ${pkgs.redshift}/bin/redshift -O 1900";
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
