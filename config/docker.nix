{ config, pkgs, lib, ... }: {
  virtualisation.oci-containers.backend = "docker";

  virtualisation.oci-containers.containers = {
    nginx = {
      image = "dceoy/nginx-autoindex";
      ports = [ "127.0.0.1:10070:80" ];
      volumes = [
                  "/home/user/.config/nginx/mime.types:/etc/nginx/mime.types:ro"
                  "/home/user/git:/var/lib/nginx/html:ro"
                ];
    };

    #openvas = {
    #  image = "greenbone/openvas";
    #  ports = [ "127.0.0.1:8030:443" ];
    #};

    cyberchef = {
      image = "mpepping/cyberchef";
      ports = [ "127.0.0.1:8040:8000" ];
    };

    mobsf = {
      image = "opensecurity/mobile-security-framework-mobsf";
      ports = [ "127.0.0.1:8050:8000" ];
    };

    #spiderfoot = {
    #  image = "spiderfoot";
    #  ports = [ "127.0.0.1:8060:5001" ];
    #};

    # Today's screenshots
    #filestash_screenshots = {
    #  image = "machines/filestash";
    #  ports = [ "172.20.0.1:9040:8334" ];
    #  volumes = [
    #              "filestash-screenshots:/app/data/state:rw"
    #            ];
    #};

    # Today's tmp directory
    #filestash_tmp = {
    #  image = "machines/filestash";
    #  ports = [ "172.21.0.1:9040:8334" ];
    #  volumes = [
    #              "filestash-tmp:/app/data/state:rw"
    #            ];
    #};

    houdini = {
      image = "rascal999/houdini";
      ports = [ "127.0.0.1:9050:3000" ];
    };

    #libretranslate = {
    #  extraOptions = [
    #                  "--cpus=2"
    #                 ];
    #  image = "libretranslate/libretranslate";
    #  ports = [ "127.0.0.1:9070:5000" ];
    #};

    searxng = {
      environment = { INSTANCE_NAME = "nixos-instance"; };
      image = "searxng/searxng";
      ports = [ "127.0.0.1:9080:8080" ];
    };

    #dashy = {
    #  image = "lissy93/dashy";
    #  ports = [ "127.0.0.1:9090:80" ];
    #  volumes = [ "/home/user/.config/dashy/conf.yml:/app/public/conf.yml" ];
    #};

    #grafana = {
    #  environment = {
    #                  GF_DEFAULT_INSTANCE_NAME = "grafana.home";
    #                  GF_INSTALL_PLUGINS = "grafana-strava-datasource";
    #                  GF_STRAVA_DS_DATA_PATH = "/var/lib/grafana/strava";
    #                };
    #  image = "grafana/grafana-oss";
    #  ports = [ "127.0.0.1:10060:3000" ];
    #  volumes = [
    #              "grafana-data:/var/lib/grafana"
    #              "/etc/api-strava:/etc/grafana/provisioning/datasources/strava.yaml"
    #              "/home/user/git/maxos/resources/grafana/provisioning/dashboards/:/etc/grafana/provisioning/dashboards/"
    #              "/home/user/git/maxos/resources/grafana/dashboards:/mnt/dashboards"
    #            ];
    #};

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

    #logseq-jira-sync = {
    #  cmd = [
    #          "/pages/Work_Todo.md"
    #        ];
    #  image = "logseq-jira-sync";
    #  volumes = [
    #          "/home/user/Data/logseq/pages:/pages"
    #          "/home/user/git/logseq-jira-sync:/root"
    #        ];
    #};

    #kiwix = {
    #  cmd = [
    #          "cheatography.com_en_all_2021-09.zim"
    #          "gutenberg_en_all_2022-05.zim"
    #          "wikipedia_en_all_nopic_2022-01.zim"
    #        ];
    #  image = "kiwix/kiwix-serve";
    #  ports = [ "127.0.0.1:9060:8080" ];
    #  volumes = [ "/home/user/.local/share/kiwix:/data" ];
    #};

    privatebin = {
      image = "privatebin/nginx-fpm-alpine";
      ports = [ "127.0.0.1:10040:8080" ];
      volumes = [
                  "/home/user/.privatebin/conf/conf.php:/srv/cfg/conf.php:ro"
                ];
    };

    #jsoncrack = {
    #  image = "jsoncrack";
    #  ports = [ "127.0.0.1:10090:8080" ];
    #};

    gifcap = {
      image = "rascal999/gifcap";
      ports = [ "127.0.0.1:10110:5000" ];
    };

    #attack-navigator = {
    #  image = "attack-navigator";
    #  ports = [ "127.0.0.1:10120:4200" ];
    #};

    memos = {
      image = "neosmemo/memos";
      ports = [ "127.0.0.1:10170:5230" ];
      volumes = [ "/home/user/Data/.memos/:/var/opt/memos" ];
    };

    mermaid = {
      image = "ghcr.io/mermaid-js/mermaid-live-editor";
      ports = [ "127.0.0.1:10180:80" ];
    };

    libreddit = {
      image = "libreddit/libreddit";
      ports = [ "127.0.0.1:10190:8080" ];
    };

    #graphgpt = {
    #  image = "graphgpt";
    #  ports = [ "127.0.0.1:10160:3000" ];
    #};

    rembg = {
      cmd = [
              "s"
            ];
      image = "danielgatis/rembg";
      ports = [ "127.0.0.1:10130:5000" ];
    };

    excalidraw = {
      image = "excalidraw/excalidraw:latest";
      ports = [ "127.0.0.1:10200:80" ];
    };

    web-check = {
      image = "lissy93/web-check";
      ports = [ "127.0.0.1:10230:3000" ];
    };

    jira-sync = {
      image = "jira-sync";
      volumes = [
                    "/home/user/git/jira_sync/config:/config"
                    "/home/user/Data/logseq/pages/:/watch"
                ];
    };

    #ssu = {
    #  image = "rascal999/ssu:latest";
    #  volumes = [
    #              "/home/user/Data/logseq:/monitor"
    #              "/home/user/git/slack_status_updater/.env:/.env"
    #            ];
    #};
  };

  systemd.services.docker-nginx.serviceConfig.TimeoutStopSec = lib.mkForce 15;
  systemd.services.docker-openvas.serviceConfig.TimeoutStopSec = lib.mkForce 15;
  systemd.services.docker-cyberchef.serviceConfig.TimeoutStopSec = lib.mkForce 15;
  systemd.services.docker-mobsf.serviceConfig.TimeoutStopSec = lib.mkForce 15;
  systemd.services.docker-spiderfoot.serviceConfig.TimeoutStopSec = lib.mkForce 15;
  systemd.services.docker-filestash_screenshots.serviceConfig.TimeoutStopSec = lib.mkForce 15;
  systemd.services.docker-filestash_tmp.serviceConfig.TimeoutStopSec = lib.mkForce 15;
  systemd.services.docker-houdini.serviceConfig.TimeoutStopSec = lib.mkForce 15;
  systemd.services.docker-searxng.serviceConfig.TimeoutStopSec = lib.mkForce 15;
  systemd.services.docker-dashy.serviceConfig.TimeoutStopSec = lib.mkForce 15;
  systemd.services.docker-grafana.serviceConfig.TimeoutStopSec = lib.mkForce 15;
  systemd.services.docker-gtfobins.serviceConfig.TimeoutStopSec = lib.mkForce 15;
  systemd.services.docker-drawio.serviceConfig.TimeoutStopSec = lib.mkForce 15;
  systemd.services.docker-compiler-explorer.serviceConfig.TimeoutStopSec = lib.mkForce 15;
  systemd.services.docker-netdata.serviceConfig.TimeoutStopSec = lib.mkForce 15;
  systemd.services.docker-kiwix.serviceConfig.TimeoutStopSec = lib.mkForce 15;
  systemd.services.docker-privatebin.serviceConfig.TimeoutStopSec = lib.mkForce 15;
  systemd.services.docker-jsoncrack.serviceConfig.TimeoutStopSec = lib.mkForce 15;
  systemd.services.docker-gifcap.serviceConfig.TimeoutStopSec = lib.mkForce 15;
  systemd.services.docker-attack-navigator.serviceConfig.TimeoutStopSec = lib.mkForce 15;
  systemd.services.docker-memos.serviceConfig.TimeoutStopSec = lib.mkForce 15;
  systemd.services.docker-mermaid.serviceConfig.TimeoutStopSec = lib.mkForce 15;
  systemd.services.docker-libreddit.serviceConfig.TimeoutStopSec = lib.mkForce 15;
  systemd.services.docker-rembg.serviceConfig.TimeoutStopSec = lib.mkForce 15;
  systemd.services.docker-excalidraw.serviceConfig.TimeoutStopSec = lib.mkForce 15;
  systemd.services.docker-web-check.serviceConfig.TimeoutStopSec = lib.mkForce 15;
  systemd.services.docker-jira-sync.serviceConfig.TimeoutStopSec = lib.mkForce 15;
  systemd.services.docker-ssu.serviceConfig.TimeoutStopSec = lib.mkForce 15;
}
