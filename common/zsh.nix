{ config, pkgs, lib, ... }: {
  # Zsh
  programs.zsh = {
    dirHashes = {
        dl = "$HOME/Downloads";
    };

    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;

    history = {
      size = 100000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    initExtra = builtins.readFile ../configs/zshrc.zsh + ''
      source ${./p10k.zsh}
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [ "colorize" ];
    };

    plugins = with pkgs; [
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          sha256 = "1g3pij5qn2j7v7jjac2a63lxd97mcsgw6xq6k5p7835q9fjiid98";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "v0.7.1";
          sha256 = "03r6hpb5fy4yaakqm3lbf4xcvd408r44jgpv4lnzl9asp4sb9qc0";
        };
      }
      {
        file = "powerlevel10k.zsh-theme";
        name = "powerlevel10k";
        src = "${zsh-powerlevel10k}/share/zsh-powerlevel10k";
      }
    ];

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
      dig = "grc dig";
      id = "grc id";
      ps = "grc ps";
      a-r = "export TIMESTAMP = `date +%Y%m%d_%H%M%S` && asciinema rec $HOME/asciinema/asciinema_$TIMESTAMP.log";
      a-k = "grc kubectl";
      a-d = "grc docker";
      a-kga = "grc kubectl get all";
      a-dpa = "grc docker ps -a";
      a-drr = "docker run -it --rm";
      a-nixi = "nix-store -q --references /var/run/current-system/sw | cut -d'-' -f2-";
      a-pingg = "grc ping 8.8.8.8 -c 1";
      a-pip = "curl ifconfig.me";
      a-sitecopy = "wget -k -K -E -r -l 10 -p -N -F -nH ";
      a-st = "wget http://ipv4.download.thinkbroadband.com/1GB.zip -O /dev/null";
      a-ytmp3 = "youtube-dl --extract-audio --audio-format mp3 ";
      ff = "firefox ";
      ls = "grc ls";
      cat = "colorize_cat";
      less = "colorize_less";
    };
  };
}
