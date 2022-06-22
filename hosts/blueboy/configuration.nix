{ config, pkgs, lib, ... }:

{
  networking.hostName = "blueboy";
  networking.interfaces.eno1.ipv4.addresses = [ {
    address = "192.168.0.10";
    prefixLength = 24;
  }];

  networking.defaultGateway = "192.168.0.1";
  networking.nameservers = [ "8.8.8.8" ];

  #services.xserver.videoDrivers = [ "nvidia" ];
  virtualisation.docker.enableNvidia = true;

  # X11 / i3
  services.xserver = {
    enable = false;
    windowManager.i3.enable = false;

    #displayManager = {
    #  defaultSession = "none+i3";
    #  lightdm.enable = true;
    #  autoLogin.enable = true;
    #  autoLogin.user = "user";
    #};
  };

  # Jupyter
  services.jupyter = {
    ip = "0.0.0.0";
  };

  # Enable cron service
  services.cron = {
    enable = true;
    systemCronJobs = [
      "0 20 * * *        root    ${pkgs.rsync}/bin/rsync -avz --no-perms /var/lib/trilium admin@192.168.0.254:/volume1/k8s-syncthing-data/data/"
    ];
  };
}
