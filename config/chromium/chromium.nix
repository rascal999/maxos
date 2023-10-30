{ config, pkgs, lib, ... }: {
  # Firefox
  programs.chromium = {
    enable = true;

    extensions =  [
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # Dark Reader
      { id = "ddihdomdfpicmiobogkoaideoklkhbah"; } # Dark Theme
      { id = "pnhdnpnnffpijjbnhnipkehhibchdeok"; } # EpubPress
      { id = "ijfgglilaeakmoilplpcjcgjaoleopfi"; } # MultiLogin
      { id = "ecabifbgmdmgdllomnfinbmaellmclnh"; } # Reader View
      { id = "kbmfpngjjgdllneeigpgjifpgocmfgmb"; } # Reddit Enhancement Suite
      { id = "mooikfkahbdckldjjndioackbalphokd"; } # Selenium
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
      { id = "iplffkdpngmdjhlpjmppncnlhomiipha"; } # Unpaywall
      { id = "nffaoalbilbmmfgbnbgppjihopabppdk"; } # Video Speed Controller
    ];
  };
}
