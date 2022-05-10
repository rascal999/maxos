{ config, lib, pkgs, ... }:

let 
  mod = "Mod1";
in {
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod;

      fonts = ["DejaVu Sans Mono, FontAwesome 6"];

      keybindings = lib.mkOptionDefault {
        "F2" = "exec /run/current-system/sw/bin/light -U 5";
        "F3" = "exec /run/current-system/sw/bin/light -A 5";

        "${mod}+space" = "exec ${pkgs.firefox}/bin/firefox -P \"Default User\"";
        "${mod}+Shift+Return" = "exec ${pkgs.firefox}/bin/firefox -P \"Default User\" -P \"Burp\"";
        "${mod}+Shift+v" = "exec ${pkgs.virtualbox}/bin/VirtualBox";

        "${mod}+b" = "exec /home/user/burp.sh";
        "${mod}+o" = "exec ${pkgs.obsidian}/bin/obsidian";
        "${mod}+c" = "exec ${pkgs.chromium}/bin/chromium";
        "${mod}+p" = "exec ${pkgs.dmenu}/bin/dmenu_run";

        # Focus
        "${mod}+j" = "focus left";
        "${mod}+k" = "focus down";
        "${mod}+l" = "focus up";
        "${mod}+semicolon" = "focus right";

        # Move
        "${mod}+Shift+j" = "move left";
        "${mod}+Shift+k" = "move down";
        "${mod}+Shift+l" = "move up";
        "${mod}+Shift+semicolon" = "move right";

        # My multi monitor setup
        "${mod}+m" = "move workspace to output DP-2";
        "${mod}+Shift+m" = "move workspace to output DP-5";
      };

      startup = [
        #{
        #  command = "exec ${pkgs.twmnd} &";
        #  always = true;
        #  notification = false;
        #}
        {
          command = "exec ${pkgs.redshift} -O 1900";
          always = true;
          notification = false;
        }
        #{
        #  command = "${pkgs.feh}/bin/feh --bg-scale ~/background.png";
        #  always = true;
        #  notification = false;
        #}
      ];

      #bars = [
      #  {
      #    position = "bottom";
      #    statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${./i3status-rust.toml}";
      #  }
      #];
    };
  };
}
