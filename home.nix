{ config, pkgs, ... }:

{
  imports = [
    common/i3.nix
    common/xresources.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "test";
  home.homeDirectory = "/home/test";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

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

    initExtra = builtins.readFile ./configs/zshrc.zsh;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "docker" "kubectl" ];
      theme = "robbyrussell";
    };

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
      a-sitecopy = 'wget -k -K -E -r -l 10 -p -N -F -nH ';
      a-st = "wget http://ipv4.download.thinkbroadband.com/1GB.zip -O /dev/null";
      a-ytmp3 = 'youtube-dl --extract-audio --audio-format mp3 ';
      ff = 'firefox ';
      ls = "grc ls";
    };
  };
}
