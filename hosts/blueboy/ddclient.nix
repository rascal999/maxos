{ config, pkgs, lib, ... }: {
  age.secrets = {
    ddclient-password = {
      file = ../../secrets/ddclient-password.age;
    };
  };

  services.ddclient = {
    enable = true;
    domains = [ "@" ];
    passwordFile = config.age.secrets.ddclient-password.path;
    protocol = "namecheap";
    server = "dynamicdns.park-your-domain.com";
    use = "web, web=dynamicdns.park-your-domain.com/getip";
    username = "alm.gg";
  };
}
