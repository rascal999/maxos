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
        "app.update.auto" = false;

        "browser.crashReports.unsubmittedCheck.enabled" = false;
        "browser.newtabpage.activity-stream.enabled" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.ping-centre.telemetry" = false;
        "browser.search.openintab" = true;
        "browser.send_pings" = false;
        "browser.toolbars.bookmarks.visibility" = "always";

        "datareporting.policy.dataSubmissionEnabled" = false;

        "device.sensors.enabled" = false;

        "devtools.chrome.enabled" = true;
        "devtools.debugger.remote-enabled" = true;
        "devtools.inspector.showUserAgentStyles" = true;
        "devtools.theme" = "dark";

        # Disable pocket
        "extensions.pocket.enable" = false;

        # disable all the autofill prompts
        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.creditCards.enabled" = false;

        "experiments.enabled" = false;
        "experiments.supported" = false;

        "privacy.donottrackheader.enabled" = true;
        "privacy.trackingprotection.cryptomining.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        "privacy.trackingprotection.pbmode.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;

        "services.sync.engine.addons" = false;
        "services.sync.engine.passwords" = false;
        "services.sync.engine.prefs" = false;
        "services.sync.engineStatusChanged.addons" = true;

        "signon.rememberSignons" = false;

        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.server" = "";
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.updatePing.enabled" = false;

        "ui.systemUsesDarkTheme" = 1;
      };
    };
  };
}
