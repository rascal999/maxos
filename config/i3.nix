{ config, lib, pkgs, ... }:

let
  mod = "Mod1";
in {
  xsession.windowManager.i3 = {
    enable = true;

    extraConfig = ''
      default_border pixel 1
      #for_window [class=".*burp.StartBurp.*"] move to workspace "hax"
      #for_window [class=".*firefox.*"] move to workspace 1
      #for_window [class=".*Gimp.*"] move to workspace "img"

      for_window [class=".*KeePassXC.*"] move to workspace "pw"
      for_window [class=".*Logseq.*"] move to workspace "2:ls"
      for_window [class=".*Remmina.*"] move to workspace rdp
      for_window [class=".*VirtualBox Machine.*"] move to workspace "vm"
      for_window [class=".*VirtualBox Manager.*"] move to workspace "vm"
      for_window [class=".*Slack.*"] move to workspace "ytm"
      for_window [class=".*vlc.*"] move to workspace "vid"

      for_window [class=".*Chromium.*"] move to workspace "chr"

      #for_window [title=".*Plane.*"] move to workspace 3
      #for_window [title=".*WhatsApp*"] move to workspace "ytm"

      for_window [class=".*Wireshark.*"] move to workspace "fin"

      #for_window [title=".*YouTube Music.*"] move to workspace "ytm"
      no_focus [class="org.remmina.Remmina"]
      focus_on_window_activation none
    '';

    config = {
      modifier = mod;
      workspaceAutoBackAndForth = true;

      fonts = {
        names = ["DejaVu Sans Mono, FontAwesome 6"];
        style = "Semi-Condensed";
        size = 11.0;
      };

      keybindings = lib.mkDefault {
        "F2" = "exec /run/current-system/sw/bin/light -U 5";
        "F3" = "exec /run/current-system/sw/bin/light -A 5";
        "--release Print" = "exec /home/user/git/maxos/scripts/screenshot.sh";

        "Mod4+j" = "exec ${pkgs.alacritty}/bin/alacritty -o font.size=16 --config-file /home/user/.config/alacritty/alacritty.toml --command ${pkgs.tmux}/bin/tmux new-session -e JIRA_NEW=1";
        "Mod4+Shift+Return" = "exec ${pkgs.firefox}/bin/firefox -P \"Burp\"";
        "Mod4+Return" = "exec ${pkgs.firefox}/bin/firefox";
        "Mod4+space" = "exec /home/user/git/maxos/scripts/slack_toggle.sh";
        "Mod4+v" = "exec /home/user/git/maxos/scripts/clipboard.sh";
        "Mod4+x" = "exec /home/user/git/maxos/scripts/toggle_workspace.sh USB-C-0 vid zzz";

        "${mod}+Return" = "exec /home/user/git/maxos/scripts/rofi.sh";
        "${mod}+Shift+Return" = "exec /home/user/git/maxos/scripts/rofi-greenclip.sh";
        "${mod}+grave" = "exec i3-input -F 'workspace %s' -P 'goto: '";
        "${mod}+a" = "exec /home/user/git/maxos/scripts/earbuds.sh";
        "${mod}+Shift+space" = "exec ${pkgs.firefox}/bin/firefox -P \"YouTube\"";
        "${mod}+space" = "exec /home/user/git/maxos/scripts/ai_helper.sh";
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
        "${mod}+h" = "exec ${pkgs.alacritty}/bin/alacritty -o font.size=16 --config-file /home/user/.config/alacritty/alacritty.toml --command ${pkgs.tmux}/bin/tmux new-session -e TMPWORK=1";
        "${mod}+i" = "exec /home/user/git/maxos/scripts/logseq_insert_meetings.sh";
        "${mod}+Shift+h" = "exec ${pkgs.alacritty}/bin/alacritty -o font.size=16 --config-file /home/user/.config/alacritty/alacritty.toml --command ${pkgs.tmux}/bin/tmux new-session -e NOHISTFILE=1";
        "${mod}+j" = "exec ${pkgs.alacritty}/bin/alacritty -o font.size=16 --config-file /home/user/.config/alacritty/alacritty.toml --command ${pkgs.tmux}/bin/tmux new-session -e JIRALASTTICKET=1";
        "${mod}+Shift+j" = "exec ${pkgs.alacritty}/bin/alacritty -o font.size=16 --config-file /home/user/.config/alacritty/alacritty.toml --command ${pkgs.tmux}/bin/tmux new-session -e JIRATICKET=1";
        "${mod}+k" = "exec /home/user/git/maxos/scripts/keepassxc.sh";
        "${mod}+l" = "exec ${pkgs.logseq}/bin/logseq";
        "${mod}+Shift+l" = "exec sudo poweroff";
        "${mod}+m" = "exec /home/user/git/maxos/scripts/toggle_touchpad.sh";
        "${mod}+Shift+m" = "exec /home/user/git/maxos/scripts/monitors.sh";
        "${mod}+n" = "exec ${pkgs.networkmanager_dmenu}/bin/networkmanager_dmenu";
        "${mod}+o" = "exec ${pkgs.flameshot}/bin/flameshot gui --raw | ${pkgs.tesseract}/bin/tesseract stdin stdout | ${pkgs.xclip}/bin/xclip -in -selection clipboard";
        "${mod}+Shift+o" = "exec ${pkgs.obs-studio}/bin/obs";
        "${mod}+p" = "exec ${pkgs.alacritty}/bin/alacritty -o font.size=16 --config-file /home/user/.config/alacritty/alacritty.toml --command ${pkgs.tmux}/bin/tmux new-session -e JIRA_CLI=1";
        "${mod}+Shift+p" = "restart";
        "${mod}+r" = "exec /home/user/git/maxos/scripts/radio4.sh";
        #"${mod}+r" = "exec ${pkgs.alacritty}/bin/alacritty -o font.size=16 --config-file /home/user/.config/alacritty/alacritty.toml --command ${pkgs.tmux}/bin/tmux new-session -e REMOTEWORK=1";
        "--release ${mod}+s" = "exec /home/user/git/maxos/scripts/screenshot.sh";
        "${mod}+t" = "exec ${pkgs.alacritty}/bin/alacritty -o font.size=16 --config-file /home/user/.config/alacritty/alacritty.toml --command ${pkgs.tmux}/bin/tmux";
        "${mod}+Shift+t" = "exec /home/user/git/maxos/scripts/keyboard_emulate_datetime.sh";
        "${mod}+u" = "fullscreen";
        "--release ${mod}+Shift+u" = "exec /home/user/git/maxos/scripts/uuid.sh";
        "${mod}+v" = "exec QT_SCALE_FACTOR=2.5 ${pkgs.vlc}/bin/vlc";
        "${mod}+Shift+v" = "exec ${pkgs.virtualbox}/bin/VirtualBox";
        "${mod}+w" = "exec /home/user/git/maxos/scripts/rofi-workspace.sh";
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

        # Slack
        #"Mod4+j" = "exec /home/user/git/maxos/scripts/slack.sh T02ER9ABV U04GGBDUWH0";
        "Mod4+p" = "exec /home/user/git/maxos/scripts/slack.sh T02ER9ABV U06G9SFKAJ2";
        "Mod4+m" = "exec /home/user/git/maxos/scripts/slack.sh T02ER9ABV U05C566PDJ5";
        "Mod4+n" = "exec /home/user/git/maxos/scripts/slack.sh T02ER9ABV U04TV0SREKC";
        "Mod4+k" = "exec ${pkgs.alacritty}/bin/alacritty -o font.size=16 --config-file /home/user/.config/alacritty/alacritty.toml --command ${pkgs.tmux}/bin/tmux new-session -e NEW_CALENDAR_EVENT=1";
        "Mod4+b" = "exec /home/user/git/maxos/scripts/slack.sh T02ER9ABV U042RTF0MHS";
        "Mod4+s" = "exec /home/user/git/maxos/scripts/slack.sh T02ER9ABV C050ZTPBV4H";
        "Mod4+r" = "exec /home/user/git/maxos/scripts/slack.sh T02ER9ABV U04VC5P7XV1";
        "Mod4+o" = "exec /home/user/git/maxos/scripts/slack.sh T02ER9ABV U058BK3775F";
        "Mod4+t" = "exec /home/user/git/maxos/scripts/slack.sh T02ER9ABV U03SC6Q1ZLG";
        "Mod4+d" = "exec /home/user/git/maxos/scripts/slack.sh T02ER9ABV U068KQNQ341";
        "Mod4+c" = "exec /home/user/git/maxos/scripts/slack.sh T02ER9ABV C04H5N44ZM5";
      };

      window = {
        hideEdgeBorders = "both";
      };

      #workspaceAutoBackAndForth = true;

      bars = [
        {
          trayOutput = "DP-2";
          fonts = {
            names = ["DejaVu Sans Mono, FontAwesome 14"];
            style = "Semi-Condensed";
            size = 16.0;
          };

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
