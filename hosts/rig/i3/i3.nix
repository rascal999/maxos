{ config, lib, pkgs, ... }:

{
  xsession.windowManager.i3 = {
    config = {
      defaultWorkspace = "workspace number 1";

      startup = [
        {
          command = "exec ${../../../scripts/monitors.sh}";
        }
        {
          command = "exec /run/current-system/sw/bin/nvidia-settings -a GPUFanControlState=1 -a GPUTargetFanSpeed=40";
        }
        {
          command = "exec ${pkgs.redshift}/bin/redshift -O 1900";
          notification = false;
        }
        {
          command = "exec ${pkgs.firefox}/bin/firefox";
        }
        {
          command = "exec ${pkgs.logseq}/bin/logseq";
        }
        {
          command = "exec ${pkgs.teams}/bin/teams";
        }
      ];

      assigns."7" = [
        { class = "^Microsoft\\ Teams.*"; instance = "^microsoft\\ teams.*"; }
      ];
      assigns."2" = [
        { class = "^Logseq$"; instance = "^logseq$"; }
      ];
      assigns."1" = [
        { class = "^firefox$"; instance = "^Navigator$"; }
      ];
    };
  };
}
