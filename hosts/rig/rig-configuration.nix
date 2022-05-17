{ config, pkgs, lib, ... }:

{
  hardware.opengl.driSupport32Bit = true;
  networking.hostName = "rig";
  services.xserver.videoDrivers = [ "nvidia" ];
  virtualisation.docker.enableNvidia = true;

  # Enable cron service
  services.cron = {
    enable = true;
    systemCronJobs = [
      "0 12 * * *        user    ${pkgs.rsync}/bin/rsync -avz --no-perms /home/user/Data/ admin@192.168.0.254:/volume1/k8s-syncthing-data/data/"
      "0 13 * * *        user    ${pkgs.rsync}/bin/rsync -avz --no-perms /home/user/Camera/Camera admin@192.168.0.254:/volume1/k8s-syncthing-data/camera/"
    ];
  };
}
