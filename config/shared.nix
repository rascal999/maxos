# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.scanRandMacAddress = false;

  boot.kernelParams = [ "intel_pstate=active" ];
  boot.initrd.availableKernelModules = lib.optional config.boot.initrd.network.enable "virtio-pci";
  boot.initrd.network = {
    enable = true;
  };

  hardware.opengl.driSupport32Bit = true;

  services.xserver = {
    # Touchpad
    synaptics = {
      enable = true;
      vertTwoFingerScroll = true;
      palmDetect = true;
      minSpeed = "1.5";
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # No
  powerManagement.enable = false;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  hardware.enableAllFirmware = true;

  # Define a user account
  users.users.user = {
    homeMode = "750";
    isNormalUser = true;
    extraGroups = [
      "docker"
      "libvirtd"
      "kvm"
      "qemu-libvirtd"
      "vboxusers"
      "video"
      "wheel"
    ];
    shell = pkgs.zsh;
    hashedPassword = "!";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBEHhsgw+RqLwv8HjBuC5hNpfc+KTBUypsK8yw1Ay4XP user@rig"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM4iIZbKKE6NyjbyNPqsbqVoyYY/dfDg/CGbq61sChVu user@rog"
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
  };

  # Steam
  #programs.steam.enable = true;

  # List services that you want to enable:
  # Enable zsh
  programs.zsh.enable = true;

  # Firefox policy for extensions
  environment.etc."firefox/policies/policies.json".source = ./firefox/firefox-policies.json;

  # Laptop light
  programs.light.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "yes";

  security.sudo.wheelNeedsPassword = false;

  # Flakes
  #nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # For WireGuard
  networking.firewall.checkReversePath = false;

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Timesync
  #services.timesyncd.enable = true;

  # Firewall
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [
    22
    80
    443
    1337
    5900
    6443
    8000
    8080
    8081
    8082
    8083
    8084
    8085
    8384
    8443
    9020
    22000
  ];
  networking.firewall.allowedUDPPorts = [
    53
    69
    21027
    22000
  ];

  # k3s
  services.k3s.enable = false;
  #services.k3s.role = "server";

  # Ignore lid on laptops
  services.logind.lidSwitch = "ignore";

  # For Obsidian
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-18.1.0"
    "python2.7-pyjwt-1.7.1"
  ];

  # docker
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    liveRestore = false;
  };

  # Jupyter
  services.jupyter = {
    enable = true;
    notebookDir = "~/jupyter";
    password = "'sha1:1b961dc713fb:88483270a63e57d18d43cf337e629539de1436ba'";
    port = 8000;
    user = "user";
    group = "users";
  };

  systemd.services.jupyter = {
    path = [
      pkgs.bash
      "/run/current-system/sw"
    ];
  };

  systemd.services.startupTasks = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    description = "Extra tasks";
    script = "/home/user/.startup.sh";
    serviceConfig = {
      Type = "oneshot";
      User = "user";
    };
  };

  # Virtualisation
  environment.sessionVariables.LIBVIRT_DEFAULT_URI = [ "qemu:///system" ];

  virtualisation.virtualbox.host.enable = true;

  # QEMU
  virtualisation.libvirtd = {
    enable = true;
    qemu.ovmf.enable = true;
    qemu.swtpm.enable = true;
    qemu.ovmf.packages = [ pkgs.OVMFFull ];
  };

  # opensnitch
  #services.opensnitch.enable = false;

  # fonts
  fonts.fonts = with pkgs; [
    nerdfonts
    meslo-lgs-nf
  ];

  # hosts file
  networking.extraHosts =
  ''
    127.0.0.1 appwrite.ds bibliogram.ds bookstack.ds botpress.ds calibre.ds chatwoot.ds commento.ds crater.ds cryptpad.ds directus.ds discourse.ds dolibarr.ds drawio.ds element.ds ethercalc.ds etherpad.ds ethibox.ds fathom.ds firefly.ds flarum.ds framadate.ds freshrss.ds ghost.ds gitlab.ds gogs.ds grafana.ds grav.ds habitica.ds hasura.ds hedgedoc.ds huginn.ds invoiceninja.ds jenkins.ds jitsi.ds kanboard.ds listmonk.ds magento.ds mailserver.ds mailtrain.ds mastodon.ds matomo.ds mattermost.ds matterwiki.ds mautic.ds mediawiki.ds metabase.ds minio.ds mobilizon.ds monitoring.ds n8n.ds nextcloud.ds nitter.ds nocodb.ds odoo.ds passbolt.ds peertube.ds phpbb.ds pinafore.ds pixelfed.ds plume.ds polr.ds portainer.ds posthog.ds prestashop.ds pydio.ds pytition.ds rainloop.ds redmine.ds registry.ds rocketchat.ds rsshub.ds scrumblr.ds searx.ds suitecrm.ds taiga.ds talk.ds traefik.ds umami.ds uptime-kuma.ds waiting.ds wallabag.ds wekan.ds whoogle-search.ds wikijs.ds wordpress.ds writefreely.ds zammad.ds
  '';

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
