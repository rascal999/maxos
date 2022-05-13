{ config, lib, pkgs, ... }:

let 
  mod = "Mod1";
in {
  xsession.windowManager.i3 = {
    enable = true;

    extraConfig = ''
      default_border pixel 1
    '';

    config = {
      modifier = mod;

      fonts = ["DejaVu Sans Mono, FontAwesome 6"];

      keybindings = lib.mkOptionDefault {
        "F2" = "exec /run/current-system/sw/bin/light -U 5";
        "F3" = "exec /run/current-system/sw/bin/light -A 5";

        "${mod}+space" = "exec ${pkgs.firefox}/bin/firefox";
        "${mod}+Shift+c" = "kill";
        "${mod}+Shift+Return" = "exec ${pkgs.firefox}/bin/firefox -P \"Burp\"";
        "${mod}+Shift+v" = "exec ${pkgs.virtualbox}/bin/VirtualBox";

        "${mod}+b" = "exec /home/user/burp.sh";
        "${mod}+o" = "exec ${pkgs.obsidian}/bin/obsidian";
        "${mod}+c" = "exec ${pkgs.chromium}/bin/chromium";
        "${mod}+g" = "exec ${pkgs.gimp}/bin/gimp";
        "${mod}+k" = "exec ${pkgs.keepassxc}/bin/keepassxc";
        "${mod}+s" = "exec ${pkgs.scrot}/bin/gimp";
        "${mod}+t" = "exec ${pkgs.rxvt-unicode}/bin/urxvt -bg black -fg white -e ${pkgs.tmux}/bin/tmux";
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

      startup = [
        {
          command = "exec ${pkgs.redshift} -O 1900";
          always = true;
          notification = false;
        }
        #{
        #  command = "exec ${pkgs.twmnd} &";
        #  always = true;
        #  notification = false;
        #}
        #{
        #  command = "${pkgs.feh}/bin/feh --bg-scale ~/background.png";
        #  always = true;
        #  notification = false;
        #}
      ];

      bars = [
        {
          fonts = [ "pango:DejaVu Sans Mono" "FontAwesome 12" ];
          position = "bottom";
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${./i3status-rust.toml}";
          colors = {
            "separator" = "#666666";
            "statusline" = "#dddddd";
            "focused_workspace" = "#0088CC #0088CC #ffffff";
            "active_workspace" = "#333333 #333333 #ffffff";
            "inactive_workspace" = "#333333 #333333 #888888";
            "urgent_workspace" = "#2f343a #900000 #ffffff";
          };
        }
      ];
    };
  };
}
