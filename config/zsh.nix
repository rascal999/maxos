{ config, pkgs, lib, ... }: {
  # Zsh
  programs.zsh = {
    dirHashes = {
        dl = "$HOME/Downloads";
    };

    enable = true;
    autosuggestion.enable = false;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 100000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    initExtra = builtins.readFile ../config/zsh/zshrc.zsh + ''
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
      lg = "lazygit";
      ff = "firefox ";
      ls = "grc ls";
    };
  };
}
