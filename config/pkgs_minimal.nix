{ config, pkgs, lib, ... }:

with pkgs;
let
  my-python-packages = python-packages: with python-packages; [
    beautifulsoup4
    distro
    flask
    pip
    requests
    setuptools
    wordcloud
  ];
  python-with-my-packages = python3.withPackages my-python-packages;
in {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    acpi                                                                                                 # Show battery status and other ACPI information
    bat                                                                                                  # A cat(1) clone with syntax highlighting and Git integration
    brightnessctl                                                                                        # This program allows you read and control device brightness
    broot                                                                                                # An interactive tree view, a fuzzy search, a balanced BFS descent and customizable commands
    choose                                                                                               # A human-friendly and fast alternative to cut and (sometimes) awk
    chromium                                                                                             #
    cht-sh                                                                                               #
    cifs-utils                                                                                           # Tools for managing Linux CIFS client filesystems
    clamav                                                                                               # Antivirus engine designed for detecting Trojans, viruses, malware and other malicious threats
    coreutils                                                                                            # The GNU Core Utilities
    cups-brother-hl3140cw                                                                                #
    dhcp                                                                                                 # Dynamic Host Configuration Protocol (DHCP) tools
    dhcpcd                                                                                               # A client for the Dynamic Host Configuration Protocol (DHCP)
    dig                                                                                                  #
    dmenu                                                                                                # A generic, highly customizable, and efficient menu for the X Window System
    docker                                                                                               # An open source project to pack, ship and run any application as a lightweight container
    docker-compose                                                                                       #
    dog                                                                                                  # cat replacement
    dos2unix                                                                                             # Convert text files with DOS or Mac line breaks to Unix line breaks and vice versa
    du-dust                                                                                              #
    duf                                                                                                  # Disk Usage/Free Utility
    dunst                                                                                                # Lightweight and customizable notification daemon
    electrum                                                                                             # A lightweight Bitcoin wallet
    evillimiter                                                                                          # Tool that monitors, analyzes and limits the bandwidth
    fd                                                                                                   # A simple, fast and user-friendly alternative to find
    feh                                                                                                  # A light-weight image viewer
    ffmpeg                                                                                               # Bindings for the ffmpeg libraries
    file                                                                                                 # A program that shows the type of files
    filezilla                                                                                            # Graphical FTP, FTPS and SFTP client
    firefox                                                                                              #
    gcc                                                                                                  #
    gimp                                                                                                 # The GNU Image Manipulation Program
    git                                                                                                  # Distributed version control system
    git-crypt                                                                                            # Transparent file encryption in git
    gnumake                                                                                              # A tool to control the generation of non-source files from sources
    gnupg                                                                                                # PHP wrapper for GpgME library that provides access to GnuPG ???
    go                                                                                                   # A tool for importing go packages into gx
    googler                                                                                              # Google Search, Google Site Search, Google News from the terminal
    gotty                                                                                                # Share your terminal as a web application
    gping                                                                                                # Ping, but with a graph
    grc                                                                                                  # A generic text colouriser
    gsettings-desktop-schemas                                                                            # Collection of GSettings schemas for settings shared by various components of a desktop
    hdparm                                                                                               # A tool to get/set ATA/SATA drive parameters under Linux
    hexedit                                                                                              # View and edit files in hexadecimal or in ASCII
    hping                                                                                                # A command-line oriented TCP/IP packet assembler/analyzer
    htop                                                                                                 # An interactive process viewer
    i3                                                                                                   # A tiling window manager
    i3status-rust                                                                                        #
    inetutils                                                                                            # Collection of common network programs
    iodine                                                                                               # NetworkManager's iodine plugin
    iotop                                                                                                # A tool to find out the processes doing the most IO
    ipcalc                                                                                               # Simple IP network calculator
    iperf2                                                                                               #
    iwd                                                                                                  # Wireless daemon for Linux
    jd-gui                                                                                               # Fast Java Decompiler with powerful GUI
    jdk                                                                                                  #
    jq                                                                                                   # Python bindings for jq, the flexible JSON processor
    jupyter                                                                                              # Installs all the Jupyter components in one go
    jython                                                                                               # Python interpreter written in Java
    k3s                                                                                                  # A lightweight Kubernetes distribution
    keepassxc                                                                                            #
    kiwix                                                                                                # An offline reader for Web content
    kompose                                                                                              # A tool to help users who are familiar with docker-compose move to Kubernetes
    kubectl                                                                                              #
    kubernetes-helm                                                                                      #
    lazygit                                                                                              # Simple terminal UI for git commands
    libnotify                                                                                            # A library that sends desktop notifications to a notification daemon
    libsecret                                                                                            # A library for storing and retrieving passwords and other secrets
    lshw                                                                                                 # Provide detailed information on the hardware configuration of the machine
    ltrace                                                                                               # Library call tracer
    mcfly                                                                                                # An upgraded ctrl-r for Bash whose history results make sense for what you're working on right now
    mcrypt                                                                                               # Replacement for old UNIX crypt(1)
    mosh                                                                                                 # Mobile shell (ssh replacement)
    mplayer                                                                                              # A movie player that supports many video formats
    mpv                                                                                                  # General-purpose media player, fork of MPlayer and mplayer2
    mtr                                                                                                  # A network diagnostics tool
    python-with-my-packages
    navi                                                                                                 # An interactive cheatsheet tool for the command-line and application launchers
    ncftp                                                                                                # Command line FTP (File Transfer Protocol) client
    netcat-gnu                                                                                           #
    nethogs                                                                                              # A small 'net top' tool, grouping bandwidth by process
    netmask                                                                                              # An IP address formatting tool
    networkmanager                                                                                       # Network configuration and management tool
    networkmanager_dmenu                                                                                 #
    nfs-utils                                                                                            # Linux user-space NFS utilities
    ngrok                                                                                                # Allows you to expose a web server running on your local machine to the internet
    nixops                                                                                               # NixOS cloud provisioning and deployment tool
    nixos-generators                                                                                     # Collection of image builders
    nixos-shell                                                                                          # Spawns lightweight nixos vms in a shell
    nload                                                                                                # Monitors network traffic and bandwidth usage with ncurses graphs
    nmap                                                                                                 # A free and open source utility for network discovery and security auditing
    nodejs                                                                                               #
    notify-desktop                                                                                       # Little application that lets you send desktop notifications with one command
    ntfs3g                                                                                               #
    openconnect                                                                                          # NetworkManager’s OpenConnect plugin
    openssh                                                                                              #
    openssl                                                                                              # A cryptographic library that implements the SSL and TLS protocols
    openvpn                                                                                              # NetworkManager's OpenVPN plugin
    p7zip                                                                                                # A new p7zip fork with additional codecs and improvements (forked from https://sourceforge.net/projects/p7zip/)
    pavucontrol                                                                                          # PulseAudio Volume Control
    pciutils                                                                                             # A collection of programs for inspecting and manipulating configuration of PCI devices
    pdfgrep                                                                                              # Commandline utility to search text in PDF files
    pdf-parser                                                                                           # Parse a PDF document
    peco                                                                                                 # Simplistic interactive filtering tool
    photon                                                                                               # RSS/Atom reader with the focus on speed, usability and a bit of unix philosophy
    protonmail-bridge                                                                                    # Use your ProtonMail account with your local e-mail client
    proxify                                                                                              # Proxy tool for HTTP/HTTPS traffic capture
    proxychains                                                                                          # Proxifier for SOCKS proxies
    pstree                                                                                               # Show the set of running processes as a tree
    putty                                                                                                # A Free Telnet/SSH Client
    pwgen                                                                                                # Password generator which creates passwords which can be easily memorized by a human
    python310                                                                                            #
    python-with-my-packages                                                                              #
    qrcp                                                                                                 # Transfer files over wifi by scanning a QR code from your terminal
    qrencode                                                                                             # C library for encoding data in a QR Code symbol
    ranger                                                                                               # File manager with minimalistic curses interface
    rdesktop                                                                                             # Open source client for Windows Terminal Services
    redshift                                                                                             # Screen color temperature manager
    redsocks                                                                                             # Transparent redirector of any TCP connection to proxy
    remmina                                                                                              # Remote desktop client written in GTK
    ripgrep                                                                                              # A utility that combines the usability of The Silver Searcher with the raw speed of grep
    ripgrep-all                                                                                          # Ripgrep, but also search in PDFs, E-Books, Office documents, zip, tar.gz, and more
    rsync                                                                                                # Fast incremental file transfer utility
    rtorrent                                                                                             #
    ruby                                                                                                 # The Ruby language
    rxvt-unicode                                                                                         # A clone of the well-known terminal emulator rxvt
    screen                                                                                               # A window manager that multiplexes a physical terminal
    screenfetch                                                                                          # Fetches system/theme information in terminal for Linux desktop screenshots
    scrot                                                                                                # A command-line screen capture utility
    signal-desktop                                                                                       # Private, simple, and secure messenger
    slack                                                                                                # Desktop client for Slack
    socat                                                                                                # Utility for bidirectional data transfer between two independent data channels
    sqlite-web                                                                                           # Web-based SQLite database browser
    sshfs                                                                                                #
    sslh                                                                                                 # Applicative Protocol Multiplexer (e.g. share SSH and HTTPS on the same port)
    stunnel                                                                                              # Universal tls/ssl wrapper
    terraform                                                                                            #
    testdisk                                                                                             # Data recovery utilities
    texlive.combined.scheme-full                                                                         #
    thefuck                                                                                              # Magnificent app which corrects your previous console command
    tig                                                                                                  # Text-mode interface for git
    tldr                                                                                                 # Simplified and community-driven man pages
    tmux                                                                                                 # Terminal multiplexer
    tor                                                                                                  # Anonymizing overlay network
    twmn                                                                                                 # A notification system for tiling window managers
    udptunnel                                                                                            # Tunnels TCP over UDP packets
    unrar                                                                                                # Utility for RAR archives
    unzip                                                                                                # An extraction utility for archives compressed in .zip format
    usbutils                                                                                             # Tools for working with USB devices, such as lsusb
    utillinux                                                                                            #
    vim                                                                                                  #
    virt-manager                                                                                         # Desktop user interface for managing virtual machines
    vlc                                                                                                  # Cross-platform media player and streaming server
    w3m                                                                                                  # A text-mode web browser
    wget                                                                                                 # Tool for retrieving files using HTTP, HTTPS, and FTP
    whois                                                                                                # Intelligent WHOIS client from Debian
    wireguard-tools                                                                                      # Tools for the WireGuard secure network tunnel
    wireshark-qt                                                                                         #
    woeusb                                                                                               # Create bootable USB disks from Windows ISO images
    x11vnc                                                                                               # A VNC server connected to a real X11 screen
    xh                                                                                                   # Friendly and fast tool for sending HTTP requests
    xkb-switch-i3                                                                                        # Switch your X keyboard layouts from the command line(i3 edition)
    xlockmore                                                                                            # Screen locker for the X Window System
    xorg.xbacklight                                                                                      #
    xorg.xeyes                                                                                           #
    xorg.xmodmap                                                                                         #
    youtube-dl                                                                                           # Emacs youtube-dl download manager
    zip                                                                                                  # Compressor/archiver for creating and modifying zipfiles
    zlib                                                                                                 # Lossless data-compression library
    zsh                                                                                                  # The Z shell
    zsh-autosuggestions                                                                                  # Fish shell autosuggestions for Zsh
    zsh-completions                                                                                      # Additional completion definitions for zsh
    zsh-powerlevel10k                                                                                    # A fast reimplementation of Powerlevel9k ZSH theme
    zsh-syntax-highlighting                                                                              # Fish shell like syntax highlighting for Zsh
  ];
}
