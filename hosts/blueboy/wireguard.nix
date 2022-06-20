{ config, pkgs, lib, ... }: {
  virtualisation.oci-containers.backend = "docker";
  virtualisation.oci-containers.containers = {
    wireguard = {
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
