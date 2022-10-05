{ config, pkgs, lib, ... }: {
  age.secrets = {
    password-ddclient = {
      file = ../../secrets/password-ddclient.age;
    };
  };

  services.ddclient = {
    enable = true;
    domains = [ "home" ];
    passwordFile = config.age.secrets.password-ddclient.path;
    protocol = "namecheap";
    server = "dynamicdns.park-your-domain.com";
    use = "web, web=dynamicdns.park-your-domain.com/getip";
    username = "alm.gg";
  };
}
