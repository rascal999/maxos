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

  boot = {
    blacklistedKernelModules = [
      "dvb_usb_rtl28xxu"
    ];

    kernelParams = [
      "intel_pstate=active"
      "transparent_hugepage=never"
    ];

    initrd.availableKernelModules = lib.optional config.boot.initrd.network.enable "virtio-pci";

    initrd.network = {
      enable = true;
    };
  };

  # Swap
  swapDevices = [{
    device = "/home/user/swapfile";
    size = (1024 * 8);
  }];

  hardware.graphics.enable32Bit = true;
  hardware.graphics.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Flatpak
  services.flatpak.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  # Enable twingate
  #services.twingate.enable = true;

  # X11 forward in SSH
  programs.ssh.forwardX11 = true;

  # No
  powerManagement.enable = false;

  # Enable sound.
  #sound.enable = true;
  hardware.pulseaudio.enable = false;
  # Enable sound with pipewire.
  #security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  hardware.enableAllFirmware = true;

  # Define a user account
  users.users.user = {
    homeMode = "750";
    isNormalUser = true;
    extraGroups = [
      "docker"
      "kvm"
      "libvirtd"
      "plugdev"
      "qemu-libvirtd"
      "vboxusers"
      "video"
      "wheel"
      "flatpak"
      "disk"
      "qemu"
      "sshd"
      "networkmanager"
      "audio"
      "root"
      "render"
    ];
    shell = pkgs.zsh;
    #hashedPassword = "$6$nmS2y4fmvuj8tfQY$uz2Ndekr9wfOXCJXgVLsLKYMs1Ub0OYlWxKxojgv6PpZaPt1puu034glTCFokjoqfc0QBTMpXDpKS4ok390YU.";
    openssh.authorizedKeys.keys = [ "ssh-dss $6$nmS2y4fmvuj8tfQY$uz2Ndekr9wfOXCJXgVLsLKYMs1Ub0OYlWxKxojgv6PpZaPt1puu034glTCFokjoqfc0QBTMpXDpKS4ok390YU. user@mac" ];
  };

  # For at command
  services.atd.enable = true;
  services.atd.allowEveryone = true;

  users.groups.atd.members = [
    "atd"
    "user"
  ];

  environment.etc."at/at.allow".source = ./at.allow;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
  };

  # Disable dnsmasq (for Pi-hole)
  services.dnsmasq.enable = false;

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;

  # List services that you want to enable:

  programs.git.config = {
    http.version = "HTTP/1.1";
    http.postBuffer = "524288000";
    core.compression = "0";
  };
 
  # Enable zsh
  programs.zsh.enable = true;

  # Firefox policy for extensions
  environment.etc."firefox/policies/policies.json".source = ./firefox/firefox-policies.json;

  # Laptop light
  programs.light.enable = true;

  security.sudo.wheelNeedsPassword = false;

  # Flakes
  #nix.package = pkgs.nixVersion.latest;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # HAM
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0bda", ATTRS{idProduct}=="2838", GROUP="users", MODE="0666", SYMLINK+="rtl_sdr"
  '';

  # Mosh
  programs.mosh.enable = true;

  # x2go
  services.x2goserver.enable = true;

  # For WireGuard
  networking.firewall.checkReversePath = false;

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
  programs.dconf.enable = true;
  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };
  #hardware.pulseaudio.extraConfig = "
  #  load-module module-switch-on-connect
  #";
  fileSystems."/var/lib/bluetooth" = {
    device = "/persist/var/lib/bluetooth";
    options = [ "bind" "noauto" "x-systemd.automount" ];
    noCheck = true;
  };

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
    8888
    9020
    22000
    24800
    25565
  ];
  networking.firewall.allowedUDPPorts = [
    53
    69
    21027
    22000
    25565
  ];

  # k3s
  services.k3s.enable = false;
  #services.k3s.role = "server";

  # Ignore lid on laptops
  services.logind.lidSwitch = "ignore";

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
    #nvidia.acceptLicense = true;
    permittedInsecurePackages = [
      "electron-27.3.11"
      "python-2.7.18.6"
      "python-2.7.18.7"
      "python-2.7.18.8"
      "xpdf-4.04"
      "python3.12-youtube-dl-2021.12.17"
    ];
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
     "steam"
     "steam-original"
     "steam-run"
    ];
  };

  # docker
  #virtualisation.docker = {
  #  enable = true;
  #  enableOnBoot = true;
  #  liveRestore = false;
  #};

  # Jupyter
  services.jupyter = {
    enable = true;
    notebookDir = "~/jupyter";
    password = "'sha1:1b961dc713fb:88483270a63e57d18d43cf337e629539de1436ba'";
    port = 8000;
    user = "user";
    group = "users";
  };

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';

  systemd.services.jupyter = {
    path = [
      pkgs.bash
      "/run/current-system/sw"
    ];
  };

  # virt-manager
  #virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  systemd.services.NetworkManager-wait-online.enable = false;

  systemd.services.startupTasks = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    description = "Extra tasks";
    script = "/home/user/nixos/scripts/startup.sh";
    serviceConfig = {
      Type = "oneshot";
      User = "user";
    };
  };

    # Virtualisation
  environment.sessionVariables.LIBVIRT_DEFAULT_URI = [ "qemu:///system" ];
  virtualisation = {
    virtualbox.host.enable = true;
    #vmware.host.enable = true;

    # QEMU
    libvirtd = {
      enable = true;
      qemu.ovmf.enable = true;
      qemu.swtpm.enable = true;
      qemu.ovmf.packages = [ pkgs.OVMFFull ];
    };
  };


  xdg.mime.defaultApplications = {
    "application/pdf" = "firefox.desktop";
    "text/html" = "firefox.desktop";
    "text/markdown" = "firefox.desktop";
    "text/x-markdown" = "firefox.desktop";
    "x-scheme-handler/about" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
    "x-scheme-handler/unknown" = "firefox.desktop";
  };

  # vim default editor
  programs.vim.enable = true;
  programs.vim.defaultEditor = true;

  # opensnitch
  #services.opensnitch.enable = false;

  # fonts
  fonts.packages = with pkgs; [
    nerdfonts
    meslo-lgs-nf
    terminus-nerdfont
  ];

  # hosts file
  networking.extraHosts =
  ''
    127.0.0.1 resources.home grafana.home appwrite.ds bibliogram.ds bookstack.ds botpress.ds calibre.ds chatwoot.ds commento.ds crater.ds cryptpad.ds directus.ds discourse.ds dolibarr.ds drawio.ds element.ds ethercalc.ds etherpad.ds ethibox.ds fathom.ds firefly.ds flarum.ds framadate.ds freshrss.ds ghost.ds gitlab.ds gogs.ds grafana.ds grav.ds habitica.ds hasura.ds hedgedoc.ds huginn.ds invoiceninja.ds jenkins.ds jitsi.ds kanboard.ds listmonk.ds magento.ds mailserver.ds mailtrain.ds mastodon.ds matomo.ds mattermost.ds matterwiki.ds mautic.ds mediawiki.ds metabase.ds minio.ds mobilizon.ds monitoring.ds n8n.ds nextcloud.ds nitter.ds nocodb.ds odoo.ds passbolt.ds peertube.ds phpbb.ds pinafore.ds pixelfed.ds plume.ds polr.ds portainer.ds posthog.ds prestashop.ds pydio.ds pytition.ds rainloop.ds redmine.ds registry.ds rocketchat.ds rsshub.ds scrumblr.ds searx.ds suitecrm.ds taiga.ds talk.ds traefik.ds umami.ds uptime-kuma.ds waiting.ds wallabag.ds wekan.ds whoogle-search.ds wikijs.ds wordpress.ds writefreely.ds zammad.ds
  '';

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
