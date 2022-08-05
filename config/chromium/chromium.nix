{ config, pkgs, lib, ... }: {
  # Firefox
  programs.chromium = {
    enable = true;

    extensions =  [
      { id = "mooikfkahbdckldjjndioackbalphokd"; } # Selenium
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
      { id = "mafbdhjdkjnoafhfelkjpchpaepjknad"; } # Dark Theme
    ];
  };
}
