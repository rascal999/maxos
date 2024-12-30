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
    backup-info = {
      file = ../secrets/backup-info.age;
    };
    credentials-backup = {
      file = ../secrets/credentials-backup.age;
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
      mode = "0400";
    };
    api-instagram =
    {
      source = config.age.secrets.api-instagram.path;
      mode = "0400";
    };
    api-nist =
    {
      source = config.age.secrets.api-nist.path;
      mode = "0400";
    };
    api-shodan =
    {
      source = config.age.secrets.api-shodan.path;
      mode = "0400";
    };
    api-strava =
    {
      source = config.age.secrets.api-strava.path;
      mode = "0400";
    };
    api-tapo-username =
    {
      source = config.age.secrets.api-tapo-username.path;
      mode = "0400";
    };
    api-tapo-password =
    {
      source = config.age.secrets.api-tapo-password.path;
      mode = "0400";
    };
    api-telegram =
    {
      source = config.age.secrets.api-telegram.path;
      mode = "0400";
    };
    api-virustotal =
    {
      source = config.age.secrets.api-virustotal.path;
      mode = "0400";
    };
    backup-info =
    {
      source = config.age.secrets.backup-info.path;
      mode = "0400";
    };
    credentials-backup =
    {
      source = config.age.secrets.credentials-backup.path;
      mode = "0400";
    };
    credentials-google =
    {
      source = config.age.secrets.credentials-google.path;
      mode = "0400";
    };
    jira =
    {
      source = config.age.secrets.jira.path;
      mode = "0400";
    };
    token-github =
    {
      source = config.age.secrets.token-github.path;
      mode = "0400";
    };
    vpn-mullvad =
    {
      source = config.age.secrets.vpn-mullvad.path;
      mode = "0400";
    };
    wg_home_pav =
    {
      source = config.age.secrets.wireguard-pav.path;
      mode = "0400";
    };
    wg_home_rig =
    {
      source = config.age.secrets.wireguard-rig.path;
      mode = "0400";
    };
    wg_home_rog =
    {
      source = config.age.secrets.wireguard-rog.path;
      mode = "0400";
    };
  };
}
