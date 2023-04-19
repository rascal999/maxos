{ config, pkgs, lib, ... }:

{
  networking.hostName = "blueboy";
  networking.interfaces.eno1.ipv4.addresses = [ {
    address = "192.168.0.10";
    prefixLength = 24;
  }];

  networking.defaultGateway = "192.168.0.1";
  networking.nameservers = [ "8.8.8.8" ];
  networking.interfaces.eno1.mtu = 1200;

  services.xserver.videoDrivers = [ "nvidia" ];

  virtualisation = {
    docker.enableNvidia = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";

  # SSH setup for LUKS
  boot.initrd.availableKernelModules = [ "e1000e" ];

  boot.initrd.network.enable = true;
  boot.initrd.network.ssh = {
    enable = true;
    port = 22;
    authorizedKeys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBEHhsgw+RqLwv8HjBuC5hNpfc+KTBUypsK8yw1Ay4XP user@rig"
    ];
    hostKeys = [ "/etc/secrets/initrd/ssh_host_rsa_key" ];
  };

  # Authorised keys
  users.users.user = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBEHhsgw+RqLwv8HjBuC5hNpfc+KTBUypsK8yw1Ay4XP user@rig"
    ];
  };

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

  # Firewall
  networking.firewall.allowedTCPPorts = [
    8010 # ivre
  ];

  # Enable cron service
  services.cron = {
    enable = true;
    systemCronJobs = [
      "0 20 * * *        root    ${pkgs.rsync}/bin/rsync -av --no-perms /var/lib/trilium admin@192.168.0.254:/volume1/syncthing-data/data/"
      "0 2 * * *         root    cd /home/user/git/maxos/ && /home/user/git/maxos/scripts/build_vm_virtualbox_pipeline.sh"
      "0 4 * * *         root    cd /home/user/git/maxos/ && /home/user/git/maxos/scripts/build_iso.sh"
    ];
  };
}
