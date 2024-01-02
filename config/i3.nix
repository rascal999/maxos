{ config, lib, pkgs, ... }:

let
  mod = "Mod1";
in {
  xsession.windowManager.i3 = {
    enable = true;

    extraConfig = ''
      default_border pixel 1
      #for_window [class=".*burp.StartBurp.*"] move to workspace "hax"
      for_window [class=".*firefox.*"] move to workspace 1
      #for_window [class=".*Gimp.*"] move to workspace "img"
      for_window [class=".*KeePassXC.*"] move to workspace "pw"
      for_window [class=".*Logseq.*"] move to workspace "2:ls"
      for_window [class=".*Remmina.*"] move to workspace rdp
      for_window [class=".*VirtualBox Machine.*"] move to workspace "vm"
      for_window [class=".*VirtualBox Manager.*"] move to workspace "vm"
      for_window [class=".*Slack.*"] move to workspace "ytm"
      for_window [class=".*vlc.*"] move to workspace "vid"
      for_window [class=".*Chromium.*"] move to workspace "chr"
      for_window [title=".*Plane.*"] move to workspace 3
      #for_window [title=".*WhatsApp*"] move to workspace "ytm"
      for_window [class=".*Wireshark.*"] move to workspace "fin"
      #for_window [title=".*YouTube Music.*"] move to workspace "ytm"
      no_focus [class="org.remmina.Remmina"]
      focus_on_window_activation none
    '';

    config = {
      modifier = mod;

      fonts = ["DejaVu Sans Mono, FontAwesome 6"];

      keybindings = lib.mkDefault {
        "F2" = "exec /run/current-system/sw/bin/light -U 5";
        "F3" = "exec /run/current-system/sw/bin/light -A 5";
        "--release Print" = "exec /home/user/git/maxos/scripts/screenshot.sh";

        "${mod}+Return" = "exec ${pkgs.firefox}/bin/firefox";
        "${mod}+Shift+Return" = "exec ${pkgs.firefox}/bin/firefox -P \"Burp\"";
        "${mod}+grave" = "exec i3-input -F 'workspace %s' -P 'goto: '";
        "${mod}+space" = "exec ${pkgs.bluez}/bin/bluetoothctl connect AC:80:0A:48:04:62";
        "${mod}+Shift+space" = "exec ${pkgs.firefox}/bin/firefox -P \"YouTube\"";
        "--release ${mod}+Shift+s" = "exec /home/user/git/maxos/scripts/screenshot.sh focused";
        "${mod}+Tab" = "exec i3-input -F 'move container to workspace %s' -P 'move: '";

        "${mod}+b" = "exec /home/user/git/maxos/scripts/burp.sh";
        "${mod}+c" = "exec /home/user/git/maxos/scripts/chromium.sh";
        "${mod}+Shift+c" = "kill";
        "${mod}+d" = "exec ${pkgs.dmenu}/bin/dmenu_run";
        "${mod}+e" = "exec /home/user/git/maxos/scripts/i3-split.sh splith";
        "${mod}+f" = "exec /home/user/git/maxos/scripts/tapo_fan_toggle.sh";
        "${mod}+Shift+e" = "exec /home/user/git/maxos/scripts/i3-split.sh splitv";
        "${mod}+g" = "exec ${pkgs.gimp}/bin/gimp";
        "${mod}+h" = "exec ${pkgs.rxvt-unicode}/bin/urxvt -bg black -fg white -e ${pkgs.tmux}/bin/tmux new-session -e TMPWORK=1";
        "${mod}+Shift+h" = "exec ${pkgs.rxvt-unicode}/bin/urxvt -bg black -fg white -e ${pkgs.tmux}/bin/tmux new-session -e NOHISTFILE=1";
        "${mod}+k" = "exec /home/user/git/maxos/scripts/keepassxc.sh";
        "${mod}+l" = "exec ${pkgs.logseq}/bin/logseq";
        "${mod}+Shift+l" = "exec sudo poweroff";
        "${mod}+m" = "exec /home/user/git/maxos/scripts/toggle_touchpad.sh";
        "${mod}+Shift+m" = "exec /home/user/git/maxos/scripts/monitors.sh";
        "${mod}+n" = "exec ${pkgs.networkmanager_dmenu}/bin/networkmanager_dmenu";
        "${mod}+o" = "exec ${pkgs.flameshot}/bin/flameshot gui --raw | ${pkgs.tesseract}/bin/tesseract stdin stdout | ${pkgs.xclip}/bin/xclip -in -selection clipboard";
        "${mod}+Shift+o" = "exec ${pkgs.obs-studio}/bin/obs";
        "${mod}+p" = "exec ${pkgs.chromium}/bin/chromium-browser --app=http://localhost --force-device-scale-factor=1.6";
        "${mod}+Shift+p" = "restart";
        "${mod}+r" = "exec ${pkgs.rxvt-unicode}/bin/urxvt -bg black -fg white -e ${pkgs.tmux}/bin/tmux new-session -e REMOTEWORK=1";
        "--release ${mod}+s" = "exec /home/user/git/maxos/scripts/screenshot.sh";
        "${mod}+t" = "exec ${pkgs.rxvt-unicode}/bin/urxvt -bg black -fg white -e ${pkgs.tmux}/bin/tmux";
        "${mod}+Shift+t" = "exec ${pkgs.qbittorrent}/bin/qbittorrent";
        "${mod}+u" = "fullscreen";
        "${mod}+v" = "exec QT_SCALE_FACTOR=2.5 ${pkgs.vlc}/bin/vlc";
        "${mod}+Shift+v" = "exec ${pkgs.virtualbox}/bin/VirtualBox";
        "${mod}+w" = "exec ${pkgs.rxvt-unicode}/bin/urxvt -bg black -fg white -e ${pkgs.tmux}/bin/tmux new-session -e WEBSCAN=1";
        "${mod}+Shift+w" = "exec /home/user/git/maxos/scripts/remmina.sh";
        "${mod}+x" = "exec ${pkgs.xlockmore}/bin/xlock -mode clock";
        "${mod}+Shift+x" = "exec /home/user/git/maxos/scripts/suspend.sh";

        # Focus
        "${mod}+Left" = "focus left";
        "${mod}+Down" = "focus down";
        "${mod}+Up" = "focus up";
        "${mod}+Right" = "focus right";

        # Move
        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Down" = "move down";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+Right" = "move right";

        # Workspace
        "${mod}+0" = "workspace number 10";
        "${mod}+1" = "workspace number 1";
        "${mod}+2" = "workspace 2:ls";
        "${mod}+3" = "workspace number 3";
        "${mod}+4" = "workspace number 4";
        "${mod}+5" = "workspace number 5";
        "${mod}+6" = "workspace number 6";
        "${mod}+7" = "workspace number 7";
        "${mod}+8" = "workspace number 8";
        "${mod}+9" = "workspace number 9";
        "${mod}+Shift+0" = "move container to workspace number 10";
        "${mod}+Shift+1" = "move container to workspace number 1";
        "${mod}+Shift+2" = "move container to workspace 2:ls";
        "${mod}+Shift+3" = "move container to workspace number 3";
        "${mod}+Shift+4" = "move container to workspace number 4";
        "${mod}+Shift+5" = "move container to workspace number 5";
        "${mod}+Shift+6" = "move container to workspace number 6";
        "${mod}+Shift+7" = "move container to workspace number 7";
        "${mod}+Shift+8" = "move container to workspace number 8";
        "${mod}+Shift+9" = "move container to workspace number 9";
      };

      window = {
        hideEdgeBorders = "both";
      };

      #workspaceAutoBackAndForth = true;

      bars = [
        {
          tray_output = "HDMI-0";
          fonts = [ "DejaVu Sans Mono" "FontAwesome 14" ];
          position = "bottom";
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${./i3status-rust.toml}";
          colors = {
            "separator" = "#666666";
            "statusline" = "#dddddd";
            "focusedWorkspace" = {
              "background" = "#0088CC";
              "border" = "#0088CC";
              "text" = "#ffffff";
            };
            "activeWorkspace" = {
              "background" = "#333333";
              "border" = "#333333";
              "text" = "#ffffff";
            };
            "inactiveWorkspace" = {
              "background" = "#333333";
              "border" = "#333333";
              "text" = "#888888";
            };
            "urgentWorkspace" = {
              "background" = "#2f343a";
              "border" = "#900000";
              "text" = "#ffffff";
            };
          };
        }
      ];
    };
  };
}
