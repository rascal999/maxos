{ config, pkgs, lib, ... }:

{
  networking.hostName = "rig";
  services.xserver.videoDrivers = [ "nvidia" ];
  virtualisation.docker.enableNvidia = true;

  # Enable cron service
  services.cron = {
    enable = true;
    systemCronJobs = [
      "45 15 * * *        user    ${pkgs.rsync}/bin/rsync -avz --no-perms /home/user/Data/ admin@192.168.0.254:/volume1/k8s-syncthing-data/data/"
      "0 16 * * *        user    ${pkgs.rsync}/bin/rsync -avz --no-perms /home/user/Camera/Camera admin@192.168.0.254:/volume1/k8s-syncthing-data/camera/"
    ];
  };
}
