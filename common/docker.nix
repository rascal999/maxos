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
      ports = [ "127.0.0.1:8030:443" ];
    };
  };
  virtualisation.oci-containers.containers = {
    cyberchef = {
      image = "mpepping/cyberchef";
      ports = [ "127.0.0.1:8040:8000" ];
    };
  };
  virtualisation.oci-containers.containers = {
    mobsf = {
      image = "opensecurity/mobile-security-framework-mobsf";
      ports = [ "127.0.0.1:8050:8000" ];
    };
  };
  virtualisation.oci-containers.containers = {
    spiderfoot = {
      image = "spiderfoot";
      ports = [ "8060:5001" ];
    };
  };
  virtualisation.oci-containers.containers = {
    filestash = {
      image = "machines/filestash";
      ports = [ "9040:8334" ];
    };
  };
  virtualisation.oci-containers.containers = {
    houdini = {
      image = "rascal999/houdini";
      ports = [ "9050:3000" ];
    };
  };
}
