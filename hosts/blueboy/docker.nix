{ config, pkgs, lib, ... }: {
  virtualisation.oci-containers.backend = "docker";
  #virtualisation.oci-containers.containers = {
  #  focalboard = {
  #    image = "mattermost/focalboard";
  #    ports = [ "127.0.0.1:9010:8000" ];
  #    volumes = [ "/home/user/Data/focalboard:/data"];
  #  };
  #};
  virtualisation.oci-containers.containers = {
    openvas = {
      image = "greenbone/openvas";
      ports = [ "8030:443" ];
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
    }
  };
}
