{ config, pkgs, lib, ... }: {
  # Secrets
  age.secrets = {
    api-nist = {
      file = ../secrets/api-nist.age;
    };
    api-shodan = {
      file = ../secrets/api-shodan.age;
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
  };
}
