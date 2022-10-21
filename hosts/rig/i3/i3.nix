{ config, lib, pkgs, ... }:

{
  xsession.windowManager.i3 = {
    config = {
      defaultWorkspace = "workspace number 1";

      startup = [
        {
          command = "exec ${../../../scripts/monitors.sh} ${./rig-workspace-1.json} ${./rig-workspace-2.json} ${./rig-workspace-7.json}";
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
          workspace = "1";
        }
        {
          command = "exec ${pkgs.chromium}/bin/chromium --force-device-scale-factor=1.6";
          workspace = "7";
        }
        {
          command = "exec ${pkgs.logseq}/bin/logseq";
          workspace = "10";
        }
      ];
    };
  };
}
