{ config, pkgs, lib, ... }: {
  # Firefox
  programs.firefox = {
    enable = true;

    profiles =
      let defaultSettings = {
        "app.update.auto" = false;

        "browser.aboutConfig.showWarning" = false;
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
        "devtools.debugger.remote-enabled" = false;
        "devtools.inspector.showUserAgentStyles" = true;
        "devtools.theme" = "dark";

        "extensions.autoDisableScopes" = "0";

        # Disable pocket
        "extensions.pocket.enable" = false;

        # disable all the autofill prompts
        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.creditCards.enabled" = false;

        "experiments.enabled" = false;
        "experiments.supported" = false;

        # Because I'm blind
        "layout.css.devPixelsPerPx" = "1.5";

        # Total Cookie Protection
        "network.cookie.cookieBehavior" = 5;

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

        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

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
    in {
      default = {
        id = 0;
        name = "Default";
        isDefault = true;
        settings = defaultSettings;

        userChrome = import ./css/userChrome.css;
        userContent = import ./css/userContent.css;
      };

      burp = {
        id = 1;
        name = "Burp";
        isDefault = false;
        settings = defaultSettings;

        userChrome = import ./css/userChromeBurp.css;
        userContent = import ./css/userContent.css;
      };
    };
  };
}
