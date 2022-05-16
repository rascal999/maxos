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
      plugins = [ "zsh-autosuggestions" "zsh-syntax-highlighting" ];
    };

    plugins = with pkgs; [
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
    };
  };
}
