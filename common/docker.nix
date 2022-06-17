{ config, pkgs, lib, ... }: {
  virtualisation.oci-containers.backend = "docker";
  #virtualisation.oci-containers.containers = {
  #  focalboard = {
  #    image = "mattermost/focalboard";
  #    ports = [ "9010:8000" ];
  #    volumes = [ "/home/user/Data/focalboard:/data"];
  #  };
  #};
  virtualisation.oci-containers.containers = {
    focalboard = {
      image = "zadam/trilium";
      ports = [ "9020:8080" ];
      volumes = [ "/home/user/Data/trilium:/home/node/trilium-data"];
    };
  };
  virtualisation.oci-containers.containers = {
    openvas = {
      image = "mikesplain/openvas";
      ports = [ "8030:443" ];
    };
  };
}
