# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

with pkgs;
let
  my-python-packages = python-packages: with python-packages; [
    pip
    setuptools
    requests
  ]; 
  python-with-my-packages = python3.withPackages my-python-packages;
in {
  boot.kernelParams = [ "intel_pstate=active" ];
  boot.initrd.availableKernelModules = lib.optional config.boot.initrd.network.enable "virtio-pci";
  boot.initrd.network = {
    enable = true;
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
  #powerManagement.enable = false;

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
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     acpi
     apktool
     amass
     android-studio
     android-tools
     appimage-run
     asciinema
     atom
     autokey
     awscli
     azure-cli
     binwalk
     brightnessctl
     brillo
     #btop
     burpsuite
     calibre
     cht-sh
     chroma
     chromium
     cifs-utils
     clamav
     connman
     connman-gtk
     coreutils
     cutter
     cups-brother-hl3140cw
     dbeaver
     dex2jar
     dhcpcd
     dig
     dmenu
     docker
     docker-compose
     dunst
     electrum
     enum4linux
     #evolution
     fcrackzip
     feh
     ffmpeg
     ffuf
     file
     filezilla
     firecracker
     firectl
     firefox
     flameshot
     fswebcam
     fzf
     gcc
     genymotion
     ghidra-bin
     gimp
     git
     #gitleaks
     git-crypt
     glances
     #gnome.gnome-keyring
     gnumake
     gnupg
     go
     gobuster
     googler
     gpa
     grc
     grim
     gsettings-desktop-schemas
     hakrawler
     hexedit
     hey
     hping
     htop
     httpx
     i3
     i3status-rust
     imagemagick
     inetutils
     inkscape
     iotop
     ipcalc
     iwd
     jadx
     jdk
     jd-gui
     john
     jq
     jupyter
     jython
     k3s
     keepassxc
     kompose
     kubectl
     kubernetes-helm
     kustomize
     libreoffice-fresh
     libsecret
     lshw
     ltrace
     lynis
     mako
     masscan
     mcrypt
     mosh
     mplayer
     mpv
     mtr
     navi
     nethogs
     networkmanager
     neocomp
     ngrep
     ngrok
     nixos-generators
     nmap
     nodejs
     notify-desktop
     ntfs3g
     #nvidia-docker
     obsidian
     openconnect
     #opensnitch
     #opensnitch-ui
     openssh
     openssl
     openttd
     openvpn
     p7zip
     pandoc
     pass
     pavucontrol
     pciutils
     pdfgrep
     photon
     pinentry
     peco
     protonmail-bridge
     pstree
     pwgen
     python-with-my-packages
     python310
     qemu
     qemu-utils
     qrcp
     qrencode
     radare2
     ranger
     rdesktop
     redshift
     remmina
     rsync
     ruby
     rustscan
     rxvt-unicode
     screen
     screenfetch
     scrot
     sddm
     signal-desktop
     slack
     socat
     sqlite-web
     sqlmap
     sshfs
     #steam
     steampipe
     stockfish
     subfinder
     #sway
     syncthing
     terraform
     testssl
     texlive.combined.scheme-full
     thc-hydra
     thefuck
     tig
     tmux
     trufflehog
     tor
     #tor-browser-bundle-bin
     twmn
     unrar
     unzip
     velero
     virt-manager
     vim
     vlc
     vue
     w3m
     #wafw00f
     #wapiti
     waybar
     wayvnc
     wget
     whois
     win-virtio
     wireguard-tools
     wireshark-qt
     woeusb
     wpscan
     x11docker
     x11vnc
     xcalib
     xlockmore
     #xmind
     xorg.xbacklight
     xorg.xeyes
     xorg.xmodmap
     xwayland
     youtube-dl
     zip
     zlib
     zoom-us
     zotero
     zsh
     zsh-autosuggestions
     zsh-completions
     zsh-powerlevel10k
     zsh-syntax-highlighting
     #zsh-z
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
  };

  # Steam
  #programs.steam.enable = true;
  # Sway
  #programs.sway.enable = true;

  # List services that you want to enable:
  # Enable zsh
  programs.zsh.enable = true;

  # Firefox policy for extensions
  environment.etc."firefox/policies/policies.json".source = ./common/firefox/firefox-policies.json;

  # Laptop light
  programs.light.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "yes";

  security.sudo.wheelNeedsPassword = false;

  # Flakes
  #nix.package = pkgs.nixUnstable;
  #nix.extraOptions = ''
  #  experimental-features = nix-command flakes
  #'';

  # For WireGuard
  networking.firewall.checkReversePath = false;

  ## Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  ## Timesync
  services.timesyncd.enable = true;

  # Firewall
  networking.firewall.allowedTCPPorts = [
    22
    80
    443
    1337
    5900
    6443
    8080
    8081
    8082
    8083
    8084
    8085
    8443
    22000
  ];
  networking.firewall.allowedUDPPorts = [ 53 ];

  # k3s
  services.k3s.enable = false;
  services.k3s.role = "server";

  # Ignore lid on laptops
  services.logind.lidSwitch = "ignore";

  # syncthing
  #services.syncthing.enable = true;
  #services.syncthing.user = "user";
  #services.syncthing.dataDir = "/home/user/syncthing";
  #services.syncthing.configDir = "/home/user/.config/syncthing";

  # For Obsidian
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-18.1.0"
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
    description = "Clone/pull rascal999:nixos and copy Jupyter templates";
    serviceConfig = {
      Type = "forking";
      User = "${config.user}";
      script = "${config.users.users.user.home}/.startup.sh";
    };
  };

  # Virtualisation
  environment.sessionVariables.LIBVIRT_DEFAULT_URI = [ "qemu:///system" ];

  ## VirtualBox
  #virtualisation.virtualbox.host = {
  #  enable = true;
  #  enableExtensionPack = true;
  #  enableHardening = false;
  #};

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
