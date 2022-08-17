{ config, lib, pkgs, ... }:

{
  xsession.windowManager.i3 = {
    config = {
      defaultWorkspace = "workspace number 2";

      startup = [
        {
          command = "exec ${../../../scripts/monitors.sh} ${./rig-workspace-1.json} ${./rig-workspace-7.json} ${./rig-workspace-10.json}";
        }
        {
          command = "exec /run/current-system/sw/bin/nvidia-settings -a GPUFanControlState=1 -a GPUTargetFanSpeed=40";
        }
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
        {
          command = "exec ${pkgs.logseq}/bin/logseq";
          workspace = "0";
        }
      ];
    };
  };
}
