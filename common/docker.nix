{ config, pkgs, lib, ... }: {
    virtualisation.oci-containers.backend = "docker";
    virtualisation.oci-containers.containers = {
    "focalboard" = {
      image = "mattermost/focalboard";
      ports = [ "9010:80" ];
      volumes = [ "/home/user/Data/focalboard:/data"];
    };
  };
}
