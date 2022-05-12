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
        "browser.theme.toolbar-theme" = 0;
        "browser.theme.content-theme" = 0;
        "devtools.theme" = "dark";
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
      };
    };
  };
}
