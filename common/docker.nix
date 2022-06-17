{ config, pkgs, lib, ... }: {
    virtualisation.oci-containers.containers = {
    "zachlatta.com" = {
      image = "mattermost/focalboard";
      ports = [ "9010:80" ];
      volumes = [ "/home/user/Data/focalboard:/data"];
    };
  };
}
