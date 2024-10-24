{ config, pkgs, lib, ... }:

{
  networking.hostName = "rig";
  services.xserver.videoDrivers = [ "nvidia" ];
  virtualisation.docker.enableNvidia = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";

  # Authorised keys
  users.users.user = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBEHhsgw+RqLwv8HjBuC5hNpfc+KTBUypsK8yw1Ay4XP user@rig"
    ];
  };

  # X11 / i3 / Login
  services.libinput.enable = false;

  services.displayManager = {
    defaultSession = "none+i3";
    autoLogin.enable = true;
    autoLogin.user = "user";
  };

  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    windowManager.i3.enable = true;

    # Touchpad
    synaptics = {
      enable = true;
      vertTwoFingerScroll = true;
      palmDetect = true;
      minSpeed = "1.5";
    };

    xkb.layout = "gb";
    xkb.variant = "dvorakukp";
  };

  # WOL
  networking.interfaces.eno1.wakeOnLan.enable = true;

  # Point to localhost for Pi-hole
  networking.nameservers = [ "127.0.0.1" ];

  #systemd.services.ollama = {
  #  script = ''
  #    /run/current-system/sw/bin/docker-compose -f /home/user/git/maxos/resources/docker/ollama/docker-compose.yml up -d
  #  '';
  #  wantedBy = ["multi-user.target"];
  #  # If you use podman
  #  #after = ["podman.service" "podman.socket"];
  #  # If you use docker
  #  after = ["docker.service" "docker.socket"];
  #};

  # Ollama
  services.ollama.enable = true;
  #services.ollama.listenAddress = "0.0.0.0:11434";

  # Enable cron service
  # /home/user/Data rsync for when syncthing fucks up
  services.cron = {
    enable = true;
    systemCronJobs = [
      "*/5 * * * *       user    /run/current-system/sw/bin/vdirsyncer sync"
      "45 16 * * *       user    /run/current-system/sw/bin/rsync -av --progress /home/user/Data admin@192.168.0.254:/volume1/backup-data"
      "50 16 * * *       user    /run/current-system/sw/bin/rsync -av --progress /home/user/work admin@192.168.0.254:/volume1/backup-data"
      #"25 * * * *        user    /etc/profiles/per-user/user/bin/twmnc -c '### Take a break ###'"
      #"55 * * * *        user    /etc/profiles/per-user/user/bin/twmnc -c '### Take a break ###'"
      #"0 16 * * *        root    /home/user/git/maxos/scripts/backup_plane.sh"
      #"5 16 * * *        root    /home/user/git/maxos/scripts/backup_data.sh"
    ];
  };
}
