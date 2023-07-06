{ config, lib, pkgs, ... }:

{
  xsession.windowManager.i3 = {
    config = {
      defaultWorkspace = "workspace number 1";

      startup = [
        {
          command = "exec ${pkgs.copyq}/bin/copyq";
        }
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
          command = "exec ${pkgs.virtualbox}/bin/VirtualBox";
        }
        {
          command = "exec ${pkgs.chromium}/bin/chromium --force-device-scale-factor=1.6";
        }
        {
          command = "exec ${pkgs.chromium}/bin/chromium --app=http://localhost";
        }
        {
          command = "exec ${pkgs.logseq}/bin/logseq";
        }
        {
          command = "exec ${pkgs.slack}/bin/slack";
        }
        #{
        #  command = "exec ${pkgs.vlc}/bin/vlc http://192.168.0.193:8080/video";
        #}
        { # DW
          command = "exec ${pkgs.vlc}/bin/vlc https://dwamdstream102.akamaized.net/hls/live/2015525/dwstream102/index.m3u8";
        }
        { # Euronews
          command = "exec ${pkgs.vlc}/bin/vlc https://d1mpprlbe8tn2j.cloudfront.net/v1/master/7b67fbda7ab859400a821e9aa0deda20ab7ca3d2/euronewsLive/87O7AhxRUdeeIVqf/ewnsabren_eng.m3u8";
        }
        { # CNN
          command = "exec ${pkgs.vlc}/bin/vlc https://cnn-cnninternational-1-eu.rakuten.wurl.tv/playlist.m3u8";
        }
        { # CCTV
          command = "exec ${pkgs.vlc}/bin/vlc https://cd-live-stream.news.cctvplus.com/live/smil:CHANNEL2.smil/playlist.m3u8";
        }
      ];
    };
  };
}
