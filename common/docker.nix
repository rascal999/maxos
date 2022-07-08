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
      ports = [ "127.0.0.1:8060:5001" ];
    };
  };
  virtualisation.oci-containers.containers = {
    filestash = {
      image = "machines/filestash";
      ports = [ "127.0.0.1:9040:8334" ];
    };
  };
  virtualisation.oci-containers.containers = {
    houdini = {
      image = "rascal999/houdini";
      ports = [ "127.0.0.1:9050:3000" ];
    };
  };
  virtualisation.oci-containers.containers = {
    houdini = {
      image = "libretranslate/libretranslate";
      ports = [ "127.0.0.1:9070:5000" ];
    };
  };
  virtualisation.oci-containers.containers = {
    kiwix = {
      cmd = [
              "cheatography.com_en_all_2021-09.zim"
              "gutenberg_en_all_2022-05.zim"
              "wikipedia_en_all_nopic_2022-01.zim"
            ];
      image = "kiwix/kiwix-serve";
      ports = [ "127.0.0.1:9060:80" ];
      volumes = [ "/home/user/.local/share/kiwix:/data" ];
    };
  };
}
