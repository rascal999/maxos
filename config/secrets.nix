{ config, pkgs, lib, ... }: {
  # Secrets
  age.secrets = {
    api-huggingface = {
      file = ../secrets/api-huggingface.age;
    };
    api-instagram = {
      file = ../secrets/api-instagram.age;
    };
    api-nist = {
      file = ../secrets/api-nist.age;
    };
    api-shodan = {
      file = ../secrets/api-shodan.age;
    };
    api-strava = {
      file = ../secrets/api-strava.age;
    };
    api-tapo-username = {
      file = ../secrets/api-tapo-username.age;
    };
    api-tapo-password = {
      file = ../secrets/api-tapo-password.age;
    };
    api-telegram = {
      file = ../secrets/api-telegram.age;
    };
    api-virustotal = {
      file = ../secrets/api-virustotal.age;
    };
    credentials-google = {
      file = ../secrets/credentials-google.age;
    };
    jira = {
      file = ../secrets/jira.age;
    };
    token-github = {
      file = ../secrets/token-github.age;
    };
    vpn-mullvad = {
      file = ../secrets/vpn-mullvad.age;
    };
    wireguard-pav = {
      file = ../secrets/wireguard-pav.age;
    };
    wireguard-rig = {
      file = ../secrets/wireguard-rig.age;
    };
    wireguard-rog = {
      file = ../secrets/wireguard-rog.age;
    };
  };

  environment.etc = {
    api-huggingface =
    {
      source = config.age.secrets.api-huggingface.path;
      mode = "0444";
    };
    api-instagram =
    {
      source = config.age.secrets.api-instagram.path;
      mode = "0444";
    };
    api-nist =
    {
      source = config.age.secrets.api-nist.path;
      mode = "0444";
    };
    api-shodan =
    {
      source = config.age.secrets.api-shodan.path;
      mode = "0444";
    };
    api-strava =
    {
      source = config.age.secrets.api-strava.path;
      mode = "0444";
    };
    api-tapo-username =
    {
      source = config.age.secrets.api-tapo-username.path;
      mode = "0444";
    };
    api-tapo-password =
    {
      source = config.age.secrets.api-tapo-password.path;
      mode = "0444";
    };
    api-telegram =
    {
      source = config.age.secrets.api-telegram.path;
      mode = "0444";
    };
    api-virustotal =
    {
      source = config.age.secrets.api-virustotal.path;
      mode = "0444";
    };
    credentials-google =
    {
      source = config.age.secrets.credentials-google.path;
      mode = "0444";
    };
    jira =
    {
      source = config.age.secrets.jira.path;
      mode = "0444";
    };
    token-github =
    {
      source = config.age.secrets.token-github.path;
      mode = "0444";
    };
    vpn-mullvad =
    {
      source = config.age.secrets.vpn-mullvad.path;
      mode = "0444";
    };
    wg_home_pav =
    {
      source = config.age.secrets.wireguard-pav.path;
      mode = "0444";
    };
    wg_home_rig =
    {
      source = config.age.secrets.wireguard-rig.path;
      mode = "0444";
    };
    wg_home_rog =
    {
      source = config.age.secrets.wireguard-rog.path;
      mode = "0444";
    };
  };
}
