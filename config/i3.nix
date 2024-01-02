{ config, lib, pkgs, ... }:

let
  mod = "Mod1";
in {
  xsession.windowManager.i3 = {
    enable = true;
  };

  home.file."i3wm-config" = {
    target = ".config/i3/config";
    text = ''
      font pango:DejaVu Sans Mono, FontAwesome 6
      floating_modifier Mod1
      default_border normal 2
      default_floating_border normal 2
      hide_edge_borders both
      focus_wrapping yes
      focus_follows_mouse yes
      focus_on_window_activation smart
      mouse_warping output
      workspace_layout default
      workspace_auto_back_and_forth no
      client.focused #4c7899 #285577 #ffffff #2e9ef4 #285577
      client.focused_inactive #333333 #5f676a #ffffff #484e50 #5f676a
      client.unfocused #333333 #222222 #888888 #292d2e #222222
      client.urgent #2f343a #900000 #ffffff #900000 #900000
      client.placeholder #000000 #0c0c0c #ffffff #000000 #0c0c0c
      client.background #ffffff
      bindsym Mod1+1 workspace number 1
      bindsym --release Mod1+Shift+s exec /home/user/git/maxos/scripts/screenshot.sh focused
      bindsym --release Mod1+s exec /home/user/git/maxos/scripts/screenshot.sh
      bindsym --release Print exec /home/user/git/maxos/scripts/screenshot.sh
      bindsym F2 exec /run/current-system/sw/bin/light -U 5
      bindsym F3 exec /run/current-system/sw/bin/light -A 5
      bindsym Mod1+0 workspace number 10
      bindsym Mod1+2 workspace 2:ls
      bindsym Mod1+3 workspace number 3
      bindsym Mod1+4 workspace number 4
      bindsym Mod1+5 workspace number 5
      bindsym Mod1+6 workspace number 6
      bindsym Mod1+7 workspace number 7
      bindsym Mod1+8 workspace number 8
      bindsym Mod1+9 workspace number 9
      bindsym Mod1+Down focus down
      bindsym Mod1+Left focus left
      bindsym Mod1+Return exec /nix/store/c3c387alqga9b9s0r4n064d6kkan07dy-firefox-119.0.1/bin/firefox
      bindsym Mod1+Right focus right
      bindsym Mod1+Shift+0 move container to workspace number 10
      bindsym Mod1+Shift+1 move container to workspace number 1
      bindsym Mod1+Shift+2 move container to workspace 2:ls
      bindsym Mod1+Shift+3 move container to workspace number 3
      bindsym Mod1+Shift+4 move container to workspace number 4
      bindsym Mod1+Shift+5 move container to workspace number 5
      bindsym Mod1+Shift+6 move container to workspace number 6
      bindsym Mod1+Shift+7 move container to workspace number 7
      bindsym Mod1+Shift+8 move container to workspace number 8
      bindsym Mod1+Shift+9 move container to workspace number 9
      bindsym Mod1+Shift+Down move down
      bindsym Mod1+Shift+Left move left
      bindsym Mod1+Shift+Return exec /nix/store/c3c387alqga9b9s0r4n064d6kkan07dy-firefox-119.0.1/bin/firefox -P "Burp"
      bindsym Mod1+Shift+Right move right
      bindsym Mod1+Shift+Up move up
      bindsym Mod1+Shift+c kill
      bindsym Mod1+Shift+e exec /home/user/git/maxos/scripts/i3-split.sh splitv
      bindsym Mod1+Shift+h exec /nix/store/97svq09kw7naf47rkcq1vmysi2bmxac4-rxvt-unicode-9.31/bin/urxvt -bg black -fg white -e /nix/store/rr0z6jxrs6fzgsykik7sfmbj15c4024g-tmux-3.3a/bin/tmux new-session -e NOHISTFILE=1
      bindsym Mod1+Shift+l exec sudo poweroff
      bindsym Mod1+Shift+m exec /home/user/git/maxos/scripts/monitors.sh
      bindsym Mod1+Shift+o exec /nix/store/irc0x45k5lns7f2kszh32s2cgvjz2vcd-obs-studio-29.1.3/bin/obs
      bindsym Mod1+Shift+p restart
      bindsym Mod1+Shift+space exec /nix/store/c3c387alqga9b9s0r4n064d6kkan07dy-firefox-119.0.1/bin/firefox -P "YouTube"
      bindsym Mod1+Shift+t exec /nix/store/lis3349fncvsbbpjpqblzbzb7k2s9j9m-qbittorrent-4.6.0/bin/qbittorrent
      bindsym Mod1+Shift+v exec /nix/store/8bq54pyhk2374zvl6idl4qs2jnfj3b6s-virtualbox-7.0.12/bin/VirtualBox
      bindsym Mod1+Shift+w exec /home/user/git/maxos/scripts/remmina.sh
      bindsym Mod1+Shift+x exec /home/user/git/maxos/scripts/suspend.sh
      bindsym Mod1+Tab exec i3-input -F 'move container to workspace %s' -P 'move: '
      bindsym Mod1+Up focus up
      bindsym Mod1+b exec /home/user/git/maxos/scripts/burp.sh
      bindsym Mod1+c exec /home/user/git/maxos/scripts/chromium.sh
      bindsym Mod1+d exec /nix/store/y6sjfqkmpb5z5i1ziw4v2zzadxdv050s-dmenu-5.2/bin/dmenu_run
      bindsym Mod1+e exec /home/user/git/maxos/scripts/i3-split.sh splith
      bindsym Mod1+f exec /home/user/git/maxos/scripts/tapo_fan_toggle.sh
      bindsym Mod1+g exec /nix/store/pwgv4bvr2dwx6vlbc7zrn34b3aj739qq-gimp-2.10.34/bin/gimp
      bindsym Mod1+grave exec i3-input -F 'workspace %s' -P 'goto: '
      bindsym Mod1+h exec /nix/store/97svq09kw7naf47rkcq1vmysi2bmxac4-rxvt-unicode-9.31/bin/urxvt -bg black -fg white -e /nix/store/rr0z6jxrs6fzgsykik7sfmbj15c4024g-tmux-3.3a/bin/tmux new-session -e TMPWORK=1
      bindsym Mod1+k exec /home/user/git/maxos/scripts/keepassxc.sh
      bindsym Mod1+l exec /nix/store/mkcxxgr52v8j4p4gsibyvb5risxbi29b-logseq-0.9.20/bin/logseq
      bindsym Mod1+m exec /home/user/git/maxos/scripts/toggle_touchpad.sh
      bindsym Mod1+n exec /nix/store/b8lqvpkanzkmjjn43r7ar302wgh22mdl-networkmanager_dmenu-2.3.1/bin/networkmanager_dmenu
      bindsym Mod1+o exec /nix/store/db1nl9lqjaz3nb1jxmvvgh0h88498r9m-flameshot-12.1.0/bin/flameshot gui --raw | /nix/store/2b3samg5y4vqla4amja15ysbwnhm38jy-tesseract-5.3.3/bin/tesseract stdin stdout | /nix/store/r0nnm38q6b2yzadpk4xc47k4ri7h7rpw-xclip-0.13/bin/xclip -in -selection clipboard
      bindsym Mod1+p exec /nix/store/nki8a5l8yxahy8dpksmkrsnwgdwnyj7p-chromium-119.0.6045.123/bin/chromium-browser --app=http://localhost --force-device-scale-factor=1.6
      bindsym Mod1+r exec /nix/store/97svq09kw7naf47rkcq1vmysi2bmxac4-rxvt-unicode-9.31/bin/urxvt -bg black -fg white -e /nix/store/rr0z6jxrs6fzgsykik7sfmbj15c4024g-tmux-3.3a/bin/tmux new-session -e REMOTEWORK=1
      bindsym Mod1+space exec /nix/store/9sm246h13pxvhzcbazq5ji6zi8rgc13j-bluez-5.66/bin/bluetoothctl connect AC:80:0A:48:04:62
      bindsym Mod1+t exec /nix/store/97svq09kw7naf47rkcq1vmysi2bmxac4-rxvt-unicode-9.31/bin/urxvt -bg black -fg white -e /nix/store/rr0z6jxrs6fzgsykik7sfmbj15c4024g-tmux-3.3a/bin/tmux
      bindsym Mod1+u fullscreen
      bindsym Mod1+v exec QT_SCALE_FACTOR=2.5 /nix/store/38d585r01xrrihhjcijrci931r712wcb-vlc-3.0.20/bin/vlc
      bindsym Mod1+w exec /nix/store/97svq09kw7naf47rkcq1vmysi2bmxac4-rxvt-unicode-9.31/bin/urxvt -bg black -fg white -e /nix/store/rr0z6jxrs6fzgsykik7sfmbj15c4024g-tmux-3.3a/bin/tmux new-session -e WEBSCAN=1
      bindsym Mod1+x exec /nix/store/kib470n0xhyg3w7kr27c2jhvjy5bhd3d-xlockmore-5.73/bin/xlock -mode clock

      mode "resize" {
        bindsym Down resize grow height 10 px or 10 ppt
        bindsym Escape mode default
        bindsym Left resize shrink width 10 px or 10 ppt
        bindsym Return mode default
        bindsym Right resize grow width 10 px or 10 ppt
        bindsym Up resize shrink height 10 px or 10 ppt
      }

      exec /nix/store/q90qxslxw0ca652fwkv76h9jfhpng95v-monitors.sh
      default_border pixel 1
      for_window [class=".*firefox.*"] move to workspace 1
      for_window [class=".*KeePassXC.*"] move to workspace "pw"
      for_window [class=".*Logseq.*"] move to workspace "2:ls"
      for_window [class=".*Remmina.*"] move to workspace rdp
      for_window [class=".*VirtualBox Machine.*"] move to workspace "vm"
      for_window [class=".*VirtualBox Manager.*"] move to workspace "vm"
      for_window [class=".*Slack.*"] move to workspace "ytm"
      for_window [class=".*vlc.*"] move to workspace "vid"
      for_window [class=".*Chromium.*"] move to workspace "chr"
      for_window [title=".*Plane.*"] move to workspace 3
      for_window [class=".*Wireshark.*"] move to workspace "fin"
      no_focus [class="org.remmina.Remmina"]
      focus_on_window_activation none

      bar {
        tray_output HDMI-0
        font pango:DejaVu Sans Mono, FontAwesome 14
        position bottom
        status_command i3status-rs /home/user/git/maxos/config/i3status-rust.toml
        i3bar_command i3bar

        colors {
          statusline #dddddd
          separator #666666
          focused_workspace  #0088CC #0088CC #ffffff
          active_workspace   #333333 #333333 #ffffff
          inactive_workspace #333333 #333333 #888888
          urgent_workspace   #900000 #2f343a #ffffff
        }
      }
    '';
  };
}
