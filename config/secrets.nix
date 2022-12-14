{ config, pkgs, lib, ... }: {
  # Secrets
  age.secrets = {
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
    api-telegram = {
      file = ../secrets/api-telegram.age;
    };
    api-virustotal = {
      file = ../secrets/api-virustotal.age;
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
    vpn-mullvad =
    {
      source = config.age.secrets.vpn-mullvad.path;
      mode = "0444";
    };
    wireguard-pav =
    {
      source = config.age.secrets.wiregurad-pav.path;
      mode = "0444";
    };
    wireguard-rig =
    {
      source = config.age.secrets.wiregurad-rig.path;
      mode = "0444";
    };
    wireguard-rog =
    {
      source = config.age.secrets.wiregurad-rog.path;
      mode = "0444";
    };
  };
}
