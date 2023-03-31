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
          command = "exec ${pkgs.remmina}/bin/remmina";
        }
        {
          command = "exec ${pkgs.virtualbox}/bin/VirtualBox";
        }
        {
          command = "exec ${pkgs.chromium}/bin/chromium --force-device-scale-factor=1.6";
        }
        {
          command = "exec ${pkgs.logseq}/bin/logseq";
        }
      ];
    };
  };
}
