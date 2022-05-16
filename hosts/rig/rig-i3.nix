{ config, lib, pkgs, ... }:

let 
  mod = "Mod1";
in {
  xsession.windowManager.i3 = {
    enable = true;

    extraConfig = ''
      default_border pixel 1
      exec --no-startup-id i3-msg "workspace 1, move workspace to output HDMI-0"
      exec --no-startup-id i3-msg "workspace 2, move workspace to output USB-C-0"
      exec --no-startup-id i3-msg "workspace 7, move workspace to output DP-4"
      exec --no-startup-id i3-msg "workspace 1, append_layout "
      exec --no-startup-id i3-msg "workspace 2, append_layout "
      exec --no-startup-id i3-msg "workspace 7, append_layout "
    '';

    config = {
      modifier = mod;

      defaultWorkspace = "workspace number 1";

      fonts = ["DejaVu Sans Mono, FontAwesome 6"];

      keybindings = lib.mkOptionDefault {
        "F2" = "exec /run/current-system/sw/bin/light -U 5";
        "F3" = "exec /run/current-system/sw/bin/light -A 5";

        "${mod}+space" = "exec ${pkgs.firefox}/bin/firefox";
        "${mod}+Shift+c" = "kill";
        "${mod}+Shift+p" = "restart";
        "${mod}+Shift+v" = "exec ${pkgs.virtualbox}/bin/VirtualBox";
        "${mod}+Shift+Return" = "exec ${pkgs.firefox}/bin/firefox -P \"Burp\"";

        "${mod}+b" = "exec /home/user/burp.sh";
        "${mod}+o" = "exec ${pkgs.obsidian}/bin/obsidian";
        "${mod}+c" = "exec ${pkgs.chromium}/bin/chromium";
        "${mod}+g" = "exec ${pkgs.gimp}/bin/gimp";
        "${mod}+k" = "exec ${pkgs.keepassxc}/bin/keepassxc";
        "${mod}+s" = "exec ${pkgs.scrot}/bin/gimp";
        "${mod}+t" = "exec ${pkgs.rxvt-unicode}/bin/urxvt -bg black -fg white -e ${pkgs.tmux}/bin/tmux";
        "${mod}+u" = "fullscreen";
        "${mod}+v" = "exec ${pkgs.vlc}/bin/vlc";
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

        # My multi monitor setup
        #"${mod}+m" = "move workspace to output DP-2";
        #"${mod}+Shift+m" = "move workspace to output DP-5";
      };

      window = {
        hideEdgeBorders = "both";
      };

      workspaceAutoBackAndForth = true;

      startup = [
        {
          command = "exec ${pkgs.redshift}/bin/redshift -O 1900";
          #always = true;
          notification = false;
        }
        {
          command = "exec ${pkgs.xorg.setxkbmap}/bin/setxkbmap dvorak";
          always = true;
          notification = false;
        }
        {
          command = "exec ${pkgs.firefox}/bin/firefox";
          #always = true;
          workspace = "1";
        }
        {
          command = "exec ${pkgs.xrandr}/bin/xrandr --output DP-4 --auto --right-of HDMI-0";
        }
        {
          command = "exec ${pkgs.xrandr}/bin/xrandr --output USB-C-0 --auto --right-of HDMI-0";
        }
        #{
        #  command = "${pkgs.feh}/bin/feh --bg-scale ~/background.png";
        #  always = true;
        #  notification = false;
        #}
      ];

      bars = [
        {
          fonts = [ "DejaVu Sans Mono" "FontAwesome 12" ];
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
