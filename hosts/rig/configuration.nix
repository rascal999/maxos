{ config, pkgs, lib, ... }:

{
  networking.hostName = "rig";
  services.xserver.videoDrivers = [ "nvidia" ];

  # docker
  virtualisation.docker = {
    enableNvidia = true;
  };

  # VirtualBox
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;

  hardware.nvidia-container-toolkit.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

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

  systemd.services.wireproxy = {
    enable = false;
    description = "wireproxy";

    # Set the command to start your application
    serviceConfig.ExecStart = "${pkgs.wireproxy}/bin/wireproxy -c /home/user/Data/nixos/wireproxy.conf";

    # Dependencies to ensure the service starts only when network is up
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];

    # Optionally, set restart policies if needed
    serviceConfig = {
      Restart = "on-failure";
      RestartSec = 5;
    };
  };

  systemd.user.services.input-leaps = {
    enable = true;
    description = "input-leaps";

    serviceConfig = {
      ExecStart = "${pkgs.input-leap}/bin/input-leaps -c /home/user/Data/nixos/input-leap.conf --disable-client-cert-checking -f";
      Environment = [
        "DISPLAY=:0"
        "XAUTHORITY=/home/user/.Xauthority"
      ];
      Restart = "on-failure";
      RestartSec = 5;
    };

    # Dependencies to ensure the service starts only when network is up
    wantedBy = ["graphical-session.target"];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
  };

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
