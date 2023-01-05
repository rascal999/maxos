{ config, lib, pkgs, ... }:

let
  mod = "Mod1";
in {
  xsession.windowManager.i3 = {
    enable = true;

    extraConfig = ''
      default_border pixel 1
      for_window [class=".*burp.StartBurp.*"] move to workspace "hax"
      for_window [class=".*Gimp.*"] move to workspace "img"
      for_window [class=".*KeePassXC.*"] move to workspace "pw"
      for_window [class=".*Logseq.*"] move to workspace 2:ls
      for_window [class=".*Remmina.*"] move to workspace 3:rdp
      for_window [class=".*VirtualBox Machine.*"] move to workspace "vm"
      for_window [class=".*VirtualBox Manager.*"] move to workspace "vm"
      for_window [class=".*Wireshark.*"] move to workspace "fin"
      for_window [instance=".*microsoft teams.*"] move to workspace "mst"
      for_window [title=".*Online LaTeX Editor Overleaf Community Edition.*"] move to workspace "5:rep"
      for_window [title=".*YouTube . Mozilla Firefox.*"] move to workspace "yt"
      for_window [title=".*YouTube Music.*"] move to workspace "ytm"
      no_focus [class="org.remmina.Remmina"]
      focus_on_window_activation none
    '';

    config = {
      modifier = mod;

      fonts = ["DejaVu Sans Mono, FontAwesome 6"];

      keybindings = lib.mkDefault {
        "F2" = "exec /run/current-system/sw/bin/light -U 5";
        "F3" = "exec /run/current-system/sw/bin/light -A 5";

        "${mod}+Return" = "exec ${pkgs.firefox}/bin/firefox";
        "${mod}+space" = "exec i3-input -F 'workspace %s' -P 'goto: '";
        "${mod}+Shift+l" = "exec sudo poweroff";
        "${mod}+Shift+space" = "exec ${pkgs.firefox}/bin/firefox -P \"YouTube\"";
        "${mod}+Shift+c" = "kill";
        "${mod}+Shift+m" = "exec /home/user/git/maxos/scripts/monitors.sh";
        "${mod}+Shift+p" = "restart";
        "${mod}+Shift+Return" = "exec ${pkgs.firefox}/bin/firefox -P \"Burp\"";
        "${mod}+Shift+t" = "exec ${pkgs.teams}/bin/teams";
        "${mod}+Shift+v" = "exec ${pkgs.virtualbox}/bin/VirtualBox";
        "${mod}+Shift+w" = "exec ${pkgs.remmina}/bin/remmina";
        "${mod}+Tab" = "exec i3-input -F 'move container to workspace %s' -P 'move: '";

        "${mod}+b" = "exec /home/user/git/maxos/scripts/burp.sh";
        "${mod}+c" = "exec ${pkgs.chromium}/bin/chromium --force-device-scale-factor=1.6";
        "${mod}+g" = "exec ${pkgs.gimp}/bin/gimp";
        "${mod}+i" = "exec ${pkgs.xcalib}/bin/xcalib -i -a";
        "${mod}+k" = "exec ${pkgs.keepassxc}/bin/keepassxc";
        "${mod}+l" = "exec ${pkgs.logseq}/bin/logseq";
        "${mod}+m" = "exec /home/user/git/maxos/scripts/toggle_touchpad.sh";
        "${mod}+n" = "exec ${pkgs.networkmanager_dmenu}/bin/networkmanager_dmenu";
        "${mod}+o" = "exec ${pkgs.obs-studio}/bin/obs";
        "${mod}+s" = "exec ${pkgs.scrot}/bin/scrot";
        "${mod}+t" = "exec ${pkgs.rxvt-unicode}/bin/urxvt -bg black -fg white -e ${pkgs.tmux}/bin/tmux";
        "${mod}+u" = "fullscreen";
        "${mod}+v" = "exec QT_SCALE_FACTOR=2.5 ${pkgs.vlc}/bin/vlc";
        "${mod}+w" = "exec sudo ${pkgs.wireshark}/bin/wireshark";
        "${mod}+x" = "exec ${pkgs.xlockmore}/bin/xlock -mode clock";

        "${mod}+p" = "exec ${pkgs.dmenu}/bin/dmenu_run";

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
        "${mod}+3" = "workspace 3:rdp";
        "${mod}+4" = "workspace number 4";
        "${mod}+5" = "workspace 5:rep";
        "${mod}+6" = "workspace number 6";
        "${mod}+7" = "workspace number 7";
        "${mod}+8" = "workspace number 8";
        "${mod}+9" = "workspace number 9";
        "${mod}+Shift+0" = "move container to workspace number 10";
        "${mod}+Shift+1" = "move container to workspace number 1";
        "${mod}+Shift+2" = "move container to workspace 2:ls";
        "${mod}+Shift+3" = "move container to workspace 3:rdp";
        "${mod}+Shift+4" = "move container to workspace number 4";
        "${mod}+Shift+5" = "move container to workspace 5:rep";
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
