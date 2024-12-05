{ config, pkgs, lib, ... }:

{

  #================================================
  #==================NETWORKING===================
  #================================================

  networking.hostName = "mac";

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";


  #================================================
  #==================VIRTULIZATION===================
  #================================================

  # docker
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  users.extraGroups.docker.members = [ "user" ];

  # podman
  #virtualisation.podman.enable = true;

  # VirtualBox
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;

  #hardware.nvidia-container-toolkit.enable = true;
  #hardware.nvidia = {
  #  modesetting.enable = true;
  #  open = false;
  #  nvidiaSettings = true;
  #  package = config.boot.kernelPackages.nvidiaPackages.latest;
  #};



  #================================================
  #==================USER===================
  #================================================  

# Authorised keys
  users.users.user = {
    openssh.authorizedKeys.keys = [
      "ssh-dss $6$nmS2y4fmvuj8tfQY$uz2Ndekr9wfOXCJXgVLsLKYMs1Ub0OYlWxKxojgv6PpZaPt1puu034glTCFokjoqfc0QBTMpXDpKS4ok390YU. user@mac"
    ];
  };


  #================================================
  #==================DESKTOP-ENV===================
  #================================================

  # Enable the GNOME Desktop Environment.

 # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # X11 / i3 / Enable the GNOME Desktop Environment.
  services = {
    libinput.enable = false;
   
    xserver = {
    enable = true;
    windowManager.i3.enable = true;
    desktopManager.gnome.enable = true;
    videoDrivers = [  ]; #"radeon" "amdgpu" "nouveau" "nvidia" "modesetting"
    
  # Touchpads
    synaptics = {
      enable = true;
      vertTwoFingerScroll = true;
      palmDetect = true;
      minSpeed = "1.5";
    };

    xkb = {
       layout = "us";
       variant = "";
      }; 

    };

    displayManager = {
      enable = true;
      #sessionPackages = [ pkgs.sway ];
      defaultSession = "gnome-xorg";
      #gdm.wayland = false; 
      autoLogin.enable = true;
      autoLogin.user = "user";
    };

  };


  #================================================
  #==================SERVICES===================
  #================================================

  # WOL
  networking.interfaces.eno1.wakeOnLan.enable = true;

  # Point to localhost for Pi-hole
  #networking.nameservers = [ "127.0.0.1" ];

  systemd.services.wireproxy = {
    enable = false;
    description = "wireproxy";

    # Set the command to start your application
    #serviceConfig.ExecStart = "${pkgs.wireproxy}/bin/wireproxy -c /home/user/Data/nixos/wireproxy.conf";

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
  #    /run/current-system/sw/bin/docker-compose -f /home/user/nixos/resources/docker/ollama/docker-compose.yml up -d
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
  #services.cron = {
  #  enable = true;
  #  systemCronJobs = [
  #    "*/5 * * * *       user    /run/current-system/sw/bin/vdirsyncer sync"
  #    "45 16 * * *       user    /run/current-system/sw/bin/rsync -av --progress /home/user/Data admin@192.168.0.254:/volume1/backup-data"
  #    "50 16 * * *       user    /run/current-system/sw/bin/rsync -av --progress /home/user/work admin@192.168.0.254:/volume1/backup-data"
      #"25 * * * *        user    /etc/profiles/per-user/user/bin/twmnc -c '### Take a break ###'"
      #"55 * * * *        user    /etc/profiles/per-user/user/bin/twmnc -c '### Take a break ###'"
      #"0 16 * * *        root    /home/user/git/maxos/scripts/backup_plane.sh"
      #"5 16 * * *        root    /home/user/git/maxos/scripts/backup_data.sh"
   # ];
  #};
}
