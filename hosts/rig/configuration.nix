{ config, pkgs, lib, ... }:

{
  networking.hostName = "rig";
  services.xserver.videoDrivers = [ "nvidia" ];
  virtualisation.docker.enableNvidia = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "yes";

  # Authorised keys
  users.users.user = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBEHhsgw+RqLwv8HjBuC5hNpfc+KTBUypsK8yw1Ay4XP user@rig"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM4iIZbKKE6NyjbyNPqsbqVoyYY/dfDg/CGbq61sChVu user@rog"
    ];
  };

  # X11 / i3
  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;

    displayManager = {
      defaultSession = "none+i3";
      lightdm.enable = true;
      autoLogin.enable = true;
      autoLogin.user = "user";
    };

    # Touchpad
    synaptics = {
      enable = true;
      vertTwoFingerScroll = true;
      palmDetect = true;
      minSpeed = "1.5";
    };

    layout = "gb";
    xkbVariant = "dvorakukp";
  };

  # WOL
  networking.interfaces.enp39s0.wakeOnLan.enable = true;

  # Point to localhost for Pi-hole
  networking.nameservers = [ "127.0.0.1" ];

  # Enable cron service
  services.cron = {
    enable = true;
    systemCronJobs = [
      "45 15 * * *       user    ${pkgs.rsync}/bin/rsync -avz --no-perms /home/user/Data/ admin@192.168.0.254:/volume1/k8s-syncthing-data/data/"
      "0 16 * * *        user    ${pkgs.rsync}/bin/rsync -avz --no-perms /home/user/Camera/Camera admin@192.168.0.254:/volume1/k8s-syncthing-data/camera/"
      "25 * * * *        user    /etc/profiles/per-user/user/bin/twmnc -c '### Take a break ###'"
      "55 * * * *        user    /etc/profiles/per-user/user/bin/twmnc -c '### Take a break ###'"
    ];
  };
}
