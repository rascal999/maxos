{ config, pkgs, lib, ... }: {
  virtualisation.oci-containers.backend = "docker";

  virtualisation.oci-containers.containers = {
    openvas = {
      image = "greenbone/openvas";
      ports = [ "127.0.0.1:8030:443" ];
    };

    cyberchef = {
      image = "mpepping/cyberchef";
      ports = [ "127.0.0.1:8040:8000" ];
    };

    mobsf = {
      image = "opensecurity/mobile-security-framework-mobsf";
      ports = [ "127.0.0.1:8050:8000" ];
    };

    spiderfoot = {
      image = "spiderfoot";
      ports = [ "127.0.0.1:8060:5001" ];
    };

    filestash = {
      image = "machines/filestash";
      ports = [ "127.0.0.1:9040:8334" ];
    };

    houdini = {
      image = "rascal999/houdini";
      ports = [ "127.0.0.1:9050:3000" ];
    };

    libretranslate = {
      extraOptions = [
                      "--cpus=2"
                     ];
      image = "libretranslate/libretranslate";
      ports = [ "127.0.0.1:9070:5000" ];
    };

    searxng = {
      environment = { INSTANCE_NAME = "nixos-instance"; };
      image = "searxng/searxng";
      ports = [ "127.0.0.1:9080:8080" ];
    };

    dashy = {
      image = "lissy93/dashy";
      ports = [ "127.0.0.1:9090:80" ];
      volumes = [ "/home/user/.config/dashy/conf.yml:/app/public/conf.yml" ];
    };

    grafana = {
      environment = {
                      GF_DEFAULT_INSTANCE_NAME = "grafana.home";
                      GF_INSTALL_PLUGINS = "grafana-strava-datasource";
                      GF_STRAVA_DS_DATA_PATH = "/var/lib/grafana/strava";
                    };
      image = "grafana/grafana-oss";
      ports = [ "127.0.0.1:10060:3000" ];
      volumes = [
                  "/etc/api-strava:/etc/grafana/provisioning/datasources/strava.yaml"
                  "/home/user/git/nixos/resources/grafana/provisioning/dashboards/:/etc/grafana/provisioning/dashboards/"
                  "/home/user/git/nixos/resources/grafana/dashboards:/mnt/dashboards"
                ];
    };

    gtfobins = {
      image = "djangobyjeffrey/gtfobins";
      ports = [ "127.0.0.1:10000:4000" ];
    };

    drawio = {
      image = "jgraph/drawio";
      ports = [ "127.0.0.1:10010:8080" ];
    };

    compiler-explorer = {
      image = "madduci/docker-compiler-explorer";
      ports = [ "127.0.0.1:10020:10240" ];
    };

    netdata = {
      extraOptions = [
                      "--cap-add=SYS_PTRACE"
                      "--security-opt=apparmor=unconfined"
                     ];
      image = "netdata/netdata";
      ports = [ "127.0.0.1:19999:19999" ];
      volumes = [
                  "netdataconfig:/etc/netdata"
                  "netdatalib:/var/lib/netdata"
                  "netdatacache:/var/cache/netdata"
                  "/etc/passwd:/host/etc/passwd:ro"
                  "/etc/group:/host/etc/group:ro"
                  "/proc:/host/proc:ro"
                  "/sys:/host/sys:ro"
                  "/etc/os-release:/host/etc/os-release:ro"
                ];
    };

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

    privatebin = {
      image = "privatebin/nginx-fpm-alpine";
      ports = [ "127.0.0.1:10040:8080" ];
      volumes = [
                  "/home/user/.privatebin/conf/conf.php:/srv/cfg/conf.php:ro"
                ];
    };
  };
}
