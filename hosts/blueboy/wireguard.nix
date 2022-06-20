{ config, pkgs, lib, ... }: {
  age.secrets = {
    wireguard-env = {
      file = ../../secrets/wireguard-env.age;
    };
  };

  virtualisation.oci-containers.backend = "docker";
  virtualisation.oci-containers.containers = {
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
                "0.0.0.0:51820:51820"
              ];
    };
  };
}
