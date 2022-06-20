{ config, pkgs, lib, ... }: {
  services.ddclient = {
    enable = true;
    passwordFile = config.age.secrets.ddclient-password.path;
    protocol = "namecheap";
    server = "dynamicdns.park-your-domain.com";
    use = "web, web=dynamicdns.park-your-domain.com/getip";
    username = "alm.gg";
  };
}
