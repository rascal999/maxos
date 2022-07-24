{ config, pkgs, lib, ... }: {
  # tmux
  programs.tmux = {
    enable = true;
    historyLimit = 100000;

    extraConfig = ''
      bind "Enter" send-keys "ls -alh" \; send-keys "Enter"
      bind "Space" send-keys "ls -alhtr" \; send-keys "Enter"
      bind "e" send-keys "exit" \; send-keys "Enter"
      bind l send-keys "duf" \; send-keys "Enter"
      bind r send-keys "uname -a" \; send-keys "Enter"
      bind u send-keys "dust ." \; send-keys "Enter"

      unbind C-b
      unbind [
      unbind ]

      set -g prefix C-Space
      set -g mode-keys vi'';
  };
}
