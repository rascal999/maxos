{ config, pkgs, lib, ... }: {
  age.secrets = {
    wireguard-env = {
      file = ../../secrets/wireguard-env.age;
    };
  };

  virtualisation.oci-containers.backend = "docker";

  virtualisation.oci-containers.containers = {
    homeassistant = {
      volumes = [ "home-assistant:/config" ];
      environment.TZ = "Europe/Berlin";
      image = "ghcr.io/home-assistant/home-assistant:stable"; # Warning: if the tag does not change, the image will not be updated
      ports = [
                "0.0.0.0:10050:8123"
              ];
    };

    wireguard = {
      environmentFiles = [
                          config.age.secrets.wireguard-env.path
                         ];
      extraOptions = [
                       "--cap-add=NET_ADMIN"
                       "--device=/dev/net/tun:/dev/net/tun"
                       "--volume=/root/wg-access-server-data:/data"
                     ];
      image = "place1/wg-access-server";
      ports = [
                "0.0.0.0:9030:8000"
                "0.0.0.0:51820:51820/udp"
              ];
    };

    cyberchef = {
      image = "mpepping/cyberchef";
      ports = [ "8040:8000" ];
    };

    mobsf = {
      image = "opensecurity/mobile-security-framework-mobsf";
      ports = [ "8050:8000" ];
    };

    spiderfoot = {
      image = "spiderfoot";
      ports = [ "8060:5001" ];
    };

    filestash = {
      image = "machines/filestash";
      ports = [ "9040:8334" ];
    };

    houdini = {
      image = "rascal999/houdini";
      ports = [ "9050:3000" ];
    };

    netbootxyz = {
      image = "ghcr.io/netbootxyz/netbootxyz";
      ports = [ "69:69/udp" ];
    };

    nginx-autoindex = {
      image = "dceoy/nginx-autoindex";
      ports = [ "10010:80" ];
      volumes = [ "/home/user/git/maxos/result:/var/lib/nginx/html:ro" ];
    };
  };
}
