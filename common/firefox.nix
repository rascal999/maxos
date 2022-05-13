{ config, pkgs, lib, ... }: {
  # Firefox
  programs.firefox = {
    enable = true;
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      bitwarden
      bypass-paywalls-clean
      darkreader
      foxyproxy-standard
      single-file
      ublock-origin
      user-agent-string-switcher
    ];
    profiles.default = {
      id = 0;
      name = "Default";
      isDefault = true;
      settings = { 
        "browser.toolbars.bookmarks.visibility" = "always";
        "browser.search.openintab" = true;
        "signon.rememberSignons" = false;
        "devtools.theme" = "dark";
        "ui.systemUsesDarkTheme" = 1;
      };
    };
  };
}
