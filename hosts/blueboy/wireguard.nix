{ config, pkgs, lib, ... }: {
  age.secrets = {
    wireguard-key = {
      file = ../../secrets/wireguard-key.age;
    };

    wireguard-password = {
      file = ../../secrets/wireguard-password.age;
    };
  };

  virtualisation.oci-containers.backend = "docker";
  virtualisation.oci-containers.containers = {
    wireguard = {
      environment = { 
                      WG_ADMIN_PASSWORD = config.age.secrets.wireguard-key.path
                      WG_WIREGUARD_PRIVATE_KEY = config.age.secrets.wireguard-key.path;
                    };
      extraOptions = [
                       "--cap-add=NET_ADMIN"
                       "--device=/dev/net/tun:/dev/net/tun"
                       "--volume=/root/wg-access-server-data:/data"
                     ];
      image = "place1/wg-access-server";
      ports = [
                "0.0.0.0:9030:8000"
                "0.0.0.0:51820:51820"
              ];
    };
  };
}
