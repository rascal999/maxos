{ config, lib, pkgs, ... }:

{
  xsession.windowManager.i3 = {
    config = {
      defaultWorkspace = "workspace number 2";

      startup = [
        {
          command = "exec ${../../../scripts/monitors.sh} ${./rig-workspace-1.json} ${./rig-workspace-2.json} ${./rig-workspace-7.json}";
        }
        {
          command = "exec /run/current-system/sw/bin/nvidia-settings -a GPUFanControlState=1 -a GPUTargetFanSpeed=40";
        }
      ];
    };
  };
}
