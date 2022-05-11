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
    syntaxHighlighting.enable = true;

    history = {
      size = 100000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    initExtra = builtins.readFile ./configs/zshrc.zsh;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "docker" "kubectl" ];
      theme = "robbyrussell";
    }

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
    };
  };
}
