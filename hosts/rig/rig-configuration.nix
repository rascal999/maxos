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
      "* * * * *        user    ${pkgs.rsync}/bin/rsync -avz --no-perms /home/user/Data/ admin@192.168.0.254:/volume1/k8s-syncthing-data/data/"
      "* * * * *        user    ${pkgs.rsync}/bin/rsync -avz --no-perms /home/user/Camera/Camera admin@192.168.0.254:/volume1/k8s-syncthing-data/camera/"
    ];
  };
}
