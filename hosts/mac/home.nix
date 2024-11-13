{ config, lib, pkgs, ... }:

{
  imports = [
    ../../config/chromium/chromium.nix
    ../../config/firefox/firefox.nix
    ../../config/i3.nix
    ../../config/tmux.nix
    ../../config/xresources.nix
    ../../config/zsh.nix
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
    ".config/alacritty/alacritty.toml".source = ../../config/alacritty/alacritty.toml;
    ".config/dashy/conf.yml".source = ../../config/dashy/conf.yml;
    ".config/nginx/mime.types".source = ../../resources/nginx/mime.types;
    ".config/dunst/dunstrc".source = ./dunst/dunstrc;
    ".config/mpv/mpv.conf".source = ../../config/mpv/mpv.conf;
    ".mime.types".source = ../../config/firefox/mime.types;
    ".privatebin/conf/conf.php".source = ../../config/privatebin/conf.php;
    #".profile".source = ./config/profile;
    ".startup.sh".source = ../../scripts/startup.sh;
    ".vimrc".source = ../../config/vimrc.nix;
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

  programs.rofi.enable = true;
  programs.rofi.plugins = [ pkgs.rofi-calc pkgs.rofi-emoji ];
  programs.rofi.theme = "/home/user/git/maxos/resources/rofi/theme";

  # Stop screen timeout
  services.screen-locker.xss-lock.screensaverCycle = 0;
}
