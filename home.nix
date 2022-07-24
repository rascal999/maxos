{ config, lib, pkgs, ... }:

{
  imports = [
    common/firefox/firefox.nix
    common/i3.nix
    common/tmux.nix
    common/xresources.nix
    common/zsh.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "user";
  home.homeDirectory = "/home/user";

  home.sessionVariables = {
    ZSH_COLORIZE_STYLE = "vim";
    EDITOR = "vim";
  };

  home.file = {
    ".config/dashy/conf.yml".source = ./config/dashy/conf.yml;
    ".mime.types".source = ./common/firefox/mime.types;
    ".startup.sh".source = ./scripts/startup.sh;
    ".vimrc".source = ./common/vimrc.nix;
  };

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
}
