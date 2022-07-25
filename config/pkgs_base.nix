{ config, pkgs, lib, ... }:

with pkgs;
let
  my-python-packages = python-packages: with python-packages; [
    beautifulsoup4
    distro
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
    abootimg                                                                                             # Manipulate Android Boot Images
    acpi                                                                                                 # Show battery status and other ACPI information
    adreaper                                                                                             # Enumeration tool for Windows Active Directories
    afflib                                                                                               # Advanced forensic format library
    afl                                                                                                  # Powerful fuzzer via genetic algorithms and instrumentation
    aflplusplus                                                                                          #
    aiodnsbrute                                                                                          # DNS brute force utility
    aircrack-ng                                                                                          # Wireless encryption cracking tools
    airgeddon                                                                                            # Multi-use TUI to audit wireless networks.
    amass                                                                                                # In-Depth DNS Enumeration and Network Mapping
    androguard                                                                                           # Tool and Python library to interact with Android Files
    android-studio                                                                                       #
    android-tools                                                                                        # Android SDK platform tools
    anevicon                                                                                             # UDP-based load generator
    apkeep                                                                                               # A command-line tool for downloading APK files from various sources
    apkleaks                                                                                             # Scanning APK file for URIs, endpoints and secrets
    apktool                                                                                              # A tool for reverse engineering Android apk files
    appimage-run                                                                                         #
    arduino                                                                                              # Basic Octave implementation of the matlab arduino extension, allowing communication to a programmed arduino board to control its hardware
    aria                                                                                                 #
    arping                                                                                               # Broadcasts a who-has ARP packet on the network and prints answers
    arp-scan                                                                                             # ARP scanning and fingerprinting tool
    asciinema                                                                                            # Terminal session recorder and the best companion of asciinema.org
    atftp                                                                                                # Advanced tftp tools
    authoscope                                                                                           # Scriptable network authentication cracker
    autokey                                                                                              # Desktop automation utility for Linux and X11
    awscli                                                                                               # Unified tool to manage your AWS services
    azure-cli                                                                                            # Next generation multi-platform command line experience for Azure
    badchars                                                                                             # HEX badchar generator for different programming languages
    bandwhich                                                                                            # A CLI utility for displaying current network utilization
    bat                                                                                                  # A cat(1) clone with syntax highlighting and Git integration
    bettercap                                                                                            # A man in the middle tool
    bingrep                                                                                              # Greps through binaries from various OSs and architectures, and colors them
    binwalk                                                                                              # A tool for searching a given binary image for embedded files
    boofuzz                                                                                              # Network protocol fuzzing tool
    bore-cli                                                                                             # Rust tool to create TCP tunnels
    brakeman                                                                                             # Static analysis security scanner for Ruby on Rails
    brightnessctl                                                                                        # This program allows you read and control device brightness
    brillo                                                                                               # Backlight and Keyboard LED control tool
    broot                                                                                                # An interactive tree view, a fuzzy search, a balanced BFS descent and customizable commands
    bruteforce-luks                                                                                      # Cracks passwords of LUKS encrypted volumes
    brutespray                                                                                           # Tool to do brute-forcing from Nmap output
    bully                                                                                                # Retrieve WPA/WPA2 passphrase from a WPS enabled access point
    burpsuite                                                                                            # An integrated platform for performing security testing of web applications
    cabextract                                                                                           # Free Software for extracting Microsoft cabinet files
    calibre                                                                                              # Comprehensive e-book software
    cameradar                                                                                            # RTSP stream access tool
    cantoolz                                                                                             # Black-box CAN network analysis framework
    cardpeek                                                                                             # A tool to read the contents of ISO7816 smart cards
    cargo-audit                                                                                          # Audit Cargo.lock files for crates with security vulnerabilities
    cariddi                                                                                              # Crawler for URLs and endpoints
    cassowary                                                                                            # Modern cross-platform HTTP load-testing tool written in Go
    certipy                                                                                              # Tool to enumerate and abuse misconfigurations in Active Directory Certificate Services
    cfripper                                                                                             # Tool for analysing CloudFormation templates
    chain-bench                                                                                          # An open-source tool for auditing your software supply chain stack for security compliance based on a new CIS Software Supply Chain benchmark
    changetower                                                                                          # Tools to watch for webppage changes
    checkip                                                                                              # CLI tool that checks an IP address using various public services
    checkov                                                                                              # Static code analysis tool for infrastructure-as-code
    checksec                                                                                             # Tool for checking security bits on executables
    cherrytree                                                                                           # An hierarchical note taking application
    chipsec                                                                                              # Platform Security Assessment Framework
    chisel                                                                                               # TCP/UDP tunnel over HTTP
    chkrootkit                                                                                           # Locally checks for signs of a rootkit
    chntpw                                                                                               # An utility to reset the password of any user that has a valid local account on a Windows system
    choose                                                                                               # A human-friendly and fast alternative to cut and (sometimes) awk
    chopchop                                                                                             # CLI to search for sensitive services/files/folders
    chroma                                                                                               # A general purpose syntax highlighter in pure Go
    chromium                                                                                             #
    cht-sh                                                                                               #
    cifs-utils                                                                                           # Tools for managing Linux CIFS client filesystems
    clair                                                                                                # Vulnerability Static Analysis for Containers
    clamav                                                                                               # Antivirus engine designed for detecting Trojans, viruses, malware and other malicious threats
    cliam                                                                                                # Cloud agnostic IAM permissions enumerator
    cloudbrute                                                                                           # Cloud enumeration tool
    cloudlist                                                                                            # Tool for listing assets from multiple cloud providers
    connman                                                                                              #
    connman-gtk                                                                                          # GTK GUI for Connman
    coreutils                                                                                            # The GNU Core Utilities
    corkscrew                                                                                            # A tool for tunneling SSH through HTTP proxies
    corsair                                                                                              #
    cowpatty                                                                                             # Offline dictionary attack against WPA/WPA2 networks
    credential-detector                                                                                  # Tool to detect potentially hard-coded credentials
    croc                                                                                                 # Easily and securely send things from one computer to another
    crowbar                                                                                              # A brute forcing tool that can be used during penetration tests
    crunch                                                                                               # Wordlist generator
    cups-brother-hl3140cw                                                                                #
    dalfox                                                                                               # Tool for analysing parameter and XSS scanning
    dbeaver                                                                                              # Universal SQL Client for developers, DBA and analysts. Supports MySQL, PostgreSQL, MariaDB, SQLite, and more
    dcfldd                                                                                               # An enhanced version of GNU dd
    ddosify                                                                                              # High-performance load testing tool, written in Golang
    ddrescue                                                                                             # GNU ddrescue, a data recovery tool
    ddrescueview                                                                                         # A tool to graphically examine ddrescue mapfiles
    deepsea                                                                                              # Phishing tool for red teams and pentesters
    detect-secrets                                                                                       # An enterprise friendly way of detecting and preventing secrets in code
    dex2jar                                                                                              # Tools to work with android .dex and java .class files
    dhcp                                                                                                 # Dynamic Host Configuration Protocol (DHCP) tools
    dhcpcd                                                                                               # A client for the Dynamic Host Configuration Protocol (DHCP)
    dhcpdump                                                                                             # A tool for visualization of DHCP packets as recorded and output by tcpdump to analyze DHCP server responses
    dig                                                                                                  #
    dirb                                                                                                 # A web content scanner
    dislocker                                                                                            # Read BitLocker encrypted partitions in Linux
    dismap                                                                                               # Asset discovery and identification tools
    dive                                                                                                 # A tool for exploring each layer in a docker image
    dmenu                                                                                                # A generic, highly customizable, and efficient menu for the X Window System
    dnsenum                                                                                              # A tool to enumerate DNS information
    dnsrecon                                                                                             # DNS Enumeration script
    dnstake                                                                                              # Tool to check missing hosted DNS zones
    dnstop                                                                                               # libpcap application that displays DNS traffic on your network
    dnstracer                                                                                            # Determines where a given Domain Name Server (DNS) gets its information from, and follows the chain of DNS servers back to the servers which know the data
    dnstwist                                                                                             # Domain name permutation engine for detecting homograph phishing attacks
    dnsx                                                                                                 # Fast and multi-purpose DNS toolkit
    docker                                                                                               # An open source project to pack, ship and run any application as a lightweight container
    docker-compose                                                                                       #
    dockle                                                                                               # Container Image Linter for Security
    dog                                                                                                  # cat replacement
    dontgo403                                                                                            # Tool to bypass 40X response codes
    doona                                                                                                # A fork of the Bruteforce Exploit Detector Tool (BED)
    dos2unix                                                                                             # Convert text files with DOS or Mac line breaks to Unix line breaks and vice versa
    driftnet                                                                                             # Watches network traffic, and picks out and displays JPEG and GIF images for display
    drill                                                                                                # HTTP load testing application inspired by Ansible syntax
    dsniff                                                                                               # collection of tools for network auditing and penetration testing
    du-dust                                                                                              #
    duf                                                                                                  # Disk Usage/Free Utility
    dunst                                                                                                # Lightweight and customizable notification daemon
    electrum                                                                                             # A lightweight Bitcoin wallet
    enum4linux                                                                                           # A tool for enumerating information from Windows and Samba systems
    enum4linux                                                                                           # A tool for enumerating information from Windows and Samba systems
    enum4linux-ng                                                                                        # Windows/Samba enumeration tool
    erosmb                                                                                               # SMB network scanner
    esptool                                                                                              # ESP8266 and ESP32 serial bootloader utility
    ettercap                                                                                             # Comprehensive suite for man in the middle attacks
    evillimiter                                                                                          # Tool that monitors, analyzes and limits the bandwidth
    evil-winrm                                                                                           # WinRM shell for hacking/pentesting
    exiv2                                                                                                # A library and command-line utility to manage image metadata
    ext4magic                                                                                            # Recover / undelete files from ext3 or ext4 partitions
    extrude                                                                                              # Tool to analyse binaries for missing security features
    extundelete                                                                                          # Utility that can recover deleted files from an ext3 or ext4 partition
    fcrackzip                                                                                            # zip password cracker, similar to fzc, zipcrack and others
    fd                                                                                                   # A simple, fast and user-friendly alternative to find
    feh                                                                                                  # A light-weight image viewer
    feroxbuster                                                                                          # Fast, simple, recursive content discovery tool
    ffmpeg                                                                                               # Bindings for the ffmpeg libraries
    ffuf                                                                                                 # Fast web fuzzer written in Go
    fierce                                                                                               # DNS reconnaissance tool for locating non-contiguous IP space
    file                                                                                                 # A program that shows the type of files
    filezilla                                                                                            # Graphical FTP, FTPS and SFTP client
    findomain                                                                                            # The fastest and cross-platform subdomain enumerator
    firecracker                                                                                          # Secure, fast, minimal micro-container virtualization
    firectl                                                                                              # A command-line tool to run Firecracker microVMs
    firefox                                                                                              #
    flameshot                                                                                            # Powerful yet simple to use screenshot software
    flashrom                                                                                             # Utility for reading, writing, erasing and verifying flash ROM chips
    foremost                                                                                             # Recover files based on their contents
    fping                                                                                                # Send ICMP echo probes to network hosts
    fswebcam                                                                                             # Neat and simple webcam app
    fwanalyzer                                                                                           # Tool to analyze filesystem images
    fzf                                                                                                  # A command-line fuzzy finder written in Go
    galer                                                                                                # Tool to fetch URLs from HTML attributes
    gammastep                                                                                            #
    gau                                                                                                  # Tool to fetch known URLs
    gcc                                                                                                  #
    gef                                                                                                  # A modern experience for GDB with advanced debugging features for exploit developers & reverse engineers
    genymotion                                                                                           # Fast and easy Android emulation
    ghidra-bin                                                                                           #
    ghost                                                                                                # Android post-exploitation framework
    gimp                                                                                                 # The GNU Image Manipulation Program
    git                                                                                                  # Distributed version control system
    git-crypt                                                                                            # Transparent file encryption in git
    gitleaks                                                                                             # Scan git repos (or files) for secrets
    glances                                                                                              # Cross-platform curses-based monitoring tool
    gnumake                                                                                              # A tool to control the generation of non-source files from sources
    gnupg                                                                                                # PHP wrapper for GpgME library that provides access to GnuPG
    go                                                                                                   # A tool for importing go packages into gx
    go365                                                                                                # Office 365 enumeration tool
    gobuster                                                                                             # Tool used to brute-force URIs, DNS subdomains, Virtual Host names on target web servers
    gokart                                                                                               # Static analysis tool for securing Go code
    gomapenum                                                                                            # Tools for user enumeration and password bruteforce
    googler                                                                                              # Google Search, Google Site Search, Google News from the terminal
    goreplay                                                                                             # Open-source tool for capturing and replaying live HTTP traffic
    gospider                                                                                             # Fast web spider written in Go
    gotestwaf                                                                                            # Tool for API and OWASP attack simulation
    gotty                                                                                                # Share your terminal as a web application
    gpa                                                                                                  # Graphical user interface for the GnuPG
    gping                                                                                                # Ping, but with a graph
    gqrx                                                                                                 # Software defined radio (SDR) receiver
    grc                                                                                                  # A generic text colouriser
    grim                                                                                                 # Grab images from a Wayland compositor
    grype                                                                                                # Vulnerability scanner for container images and filesystems
    gsettings-desktop-schemas                                                                            # Collection of GSettings schemas for settings shared by various components of a desktop
    gzrt                                                                                                 # The gzip Recovery Toolkit
    hachoir                                                                                              # Python library to view and edit a binary stream
    hakrawler                                                                                            # Web crawler for the discovery of endpoints and assets
    hans                                                                                                 # Tunnel IPv4 over ICMP
    hashcat                                                                                              # Fast password cracker
    hashcat                                                                                              # Fast password cracker
    hashcat-utils                                                                                        # Small utilities that are useful in advanced password cracking
    hashdeep                                                                                             # A set of cross-platform tools to compute hashes
    hcxtools                                                                                             # Tools for capturing wlan traffic and conversion to hashcat and John the Ripper formats
    hdparm                                                                                               # A tool to get/set ATA/SATA drive parameters under Linux
    hexedit                                                                                              # View and edit files in hexadecimal or in ASCII
    hey                                                                                                  # HTTP load generator, ApacheBench (ab) replacement
    hey                                                                                                  # HTTP load generator, ApacheBench (ab) replacement
    hivex                                                                                                # Windows registry hive extraction library
    honeytrap                                                                                            # Advanced Honeypot framework
    honggfuzz                                                                                            #
    horst                                                                                                # Small and lightweight IEEE802.11 wireless LAN analyzer with a text interface
    hping                                                                                                # A command-line oriented TCP/IP packet assembler/analyzer
    hping                                                                                                # A command-line oriented TCP/IP packet assembler/analyzer
    htop                                                                                                 # An interactive process viewer
    httpdump                                                                                             # Parse and display HTTP traffic from network device or pcap file
    httptunnel                                                                                           # Creates a bidirectional virtual data connection tunnelled in HTTP requests
    httpx                                                                                                # Fast and multi-purpose HTTP toolkit
    hyper                                                                                                # A terminal built on web technologies
    i3                                                                                                   # A tiling window manager
    i3status-rust                                                                                        #
    ike-scan                                                                                             # Tool to discover, fingerprint and test IPsec VPN servers
    ike-scan                                                                                             # Tool to discover, fingerprint and test IPsec VPN servers
    imagemagick                                                                                          #
    inetutils                                                                                            # Collection of common network programs
    inkscape                                                                                             # Vector graphics editor
    iodine                                                                                               # NetworkManager's iodine plugin
    iotop                                                                                                # A tool to find out the processes doing the most IO
    ipcalc                                                                                               # Simple IP network calculator
    ipcalc                                                                                               # Simple IP network calculator
    iperf2                                                                                               #
    ipscan                                                                                               # Fast and friendly network scanner
    iwd                                                                                                  # Wireless daemon for Linux
    jadx                                                                                                 # Dex to Java decompiler
    jaeles                                                                                               # Tool for automated Web application testing
    jaeles                                                                                               # Tool for automated Web application testing
    jd-gui                                                                                               # Fast Java Decompiler with powerful GUI
    jdk                                                                                                  #
    john                                                                                                 # John the Ripper password cracker
    john                                                                                                 # John the Ripper password cracker
    jq                                                                                                   # Python bindings for jq, the flexible JSON processor
    junkie                                                                                               # Deep packet inspection swiss-army knife
    jupyter                                                                                              # Installs all the Jupyter components in one go
    jython                                                                                               # Python interpreter written in Java
    k3s                                                                                                  # A lightweight Kubernetes distribution
    k6                                                                                                   # A modern load testing tool, using Go and JavaScript
    kalibrate-hackrf                                                                                     # Calculate local oscillator frequency offset in hackrf devices
    kalibrate-rtl                                                                                        # Calculate local oscillator frequency offset in RTL-SDR devices
    kdigger                                                                                              # An in-pod context discovery tool for Kubernetes penetration testing
    keepassxc                                                                                            #
    kerbrute                                                                                             # Kerberos bruteforce utility
    kind                                                                                                 # Kubernetes IN Docker - local clusters for testing Kubernetes
    kismet                                                                                               # Wireless network sniffer
    kiterunner                                                                                           # Contextual content discovery tool
    kiwix                                                                                                # An offline reader for Web content
    knockpy                                                                                              # Tool to scan subdomains
    kompose                                                                                              # A tool to help users who are familiar with docker-compose move to Kubernetes
    kubeaudit                                                                                            # Audit tool for Kubernetes
    kubectl                                                                                              #
    kubernetes-helm                                                                                      #
    kubescape                                                                                            # Tool for testing if Kubernetes is deployed securely
    kube-score                                                                                           # Kubernetes object analysis with recommendations for improved reliability and security
    kustomize                                                                                            # Customization of kubernetes YAML configurations
    lazygit                                                                                              # Simple terminal UI for git commands
    ldeep                                                                                                # In-depth LDAP enumeration utility
    ldeep                                                                                                # In-depth LDAP enumeration utility
    lftp                                                                                                 # A file transfer program supporting a number of network protocols
    libfreefare                                                                                          # The libfreefare project aims to provide a convenient API for MIFARE card manipulations
    libnotify                                                                                            # A library that sends desktop notifications to a notification daemon
    libreoffice-fresh                                                                                    #
    libsecret                                                                                            # A library for storing and retrieving passwords and other secrets
    lshw                                                                                                 # Provide detailed information on the hardware configuration of the machine
    ltrace                                                                                               # Library call tracer
    lynis                                                                                                # Security auditing tool for Linux, macOS, and UNIX-based systems
    lynis                                                                                                # Security auditing tool for Linux, macOS, and UNIX-based systems
    macchanger                                                                                           # A utility for viewing/manipulating the MAC address of network interfaces
    mako                                                                                                 # A lightweight Wayland notification daemon
    masscan                                                                                              # Fast scan of the Internet
    mcfly                                                                                                # An upgraded ctrl-r for Bash whose history results make sense for what you're working on right now
    mcrypt                                                                                               # Replacement for old UNIX crypt(1)
    medusa                                                                                               # A speedy, parallel, and modular, login brute-forcer
    metabigor                                                                                            # Tool to perform OSINT tasks
    mfcuk                                                                                                # MiFare Classic Universal toolKit
    mfoc                                                                                                 # Mifare Classic Offline Cracker
    mitmproxy                                                                                            # Man-in-the-middle proxy
    mongoaudit                                                                                           # MongoDB auditing and pentesting tool
    monsoon                                                                                              # Fast HTTP enumerator
    mosh                                                                                                 # Mobile shell (ssh replacement)
    mplayer                                                                                              # A movie player that supports many video formats
    mpv                                                                                                  # General-purpose media player, fork of MPlayer and mplayer2
    mtr                                                                                                  # A network diagnostics tool
    mubeng                                                                                               # Proxy checker and IP rotator
    multimon-ng                                                                                          # Multimon is a digital baseband audio protocol decoder
    naabu                                                                                                # Fast SYN/CONNECT port scanner
    nasty                                                                                                # Recover the passphrase of your PGP or GPG-key
    navi                                                                                                 # An interactive cheatsheet tool for the command-line and application launchers
    nbtscanner                                                                                           # NetBIOS scanner written in Rust
    ncftp                                                                                                # Command line FTP (File Transfer Protocol) client
    ncrack                                                                                               # Network authentication tool
    neocomp                                                                                              # A fork of Compton, a compositor for X11
    netcat-gnu                                                                                           #
    netdiscover                                                                                          # A network address discovering tool, developed mainly for those wireless networks without dhcp server, it also works on hub/switched networks
    nethogs                                                                                              # A small 'net top' tool, grouping bandwidth by process
    netmask                                                                                              # An IP address formatting tool
    netsniff-ng                                                                                          # Swiss army knife for daily Linux network plumbing
    net-snmp                                                                                             # Clients and server for the SNMP network monitoring protocol
    networkmanager                                                                                       # Network configuration and management tool
    networkmanager_dmenu                                                                                 #
    nfs-utils                                                                                            # Linux user-space NFS utilities
    ngrep                                                                                                # Network packet analyzer
    ngrep                                                                                                # Network packet analyzer
    ngrok                                                                                                # Allows you to expose a web server running on your local machine to the internet
    nixops                                                                                               # NixOS cloud provisioning and deployment tool
    nixos-generators                                                                                     # Collection of image builders
    nixos-shell                                                                                          # Spawns lightweight nixos vms in a shell
    nload                                                                                                # Monitors network traffic and bandwidth usage with ncurses graphs
    nmap                                                                                                 # A free and open source utility for network discovery and security auditing
    nmap-formatter                                                                                       # Tool that allows you to convert nmap output
    nodejs                                                                                               #
    notify-desktop                                                                                       # Little application that lets you send desktop notifications with one command
    ntfs3g                                                                                               #
    ntfs3g                                                                                               #
    nth                                                                                                  #
    ntlmrecon                                                                                            # Information enumerator for NTLM authentication enabled web endpoints
    ntopng                                                                                               # High-speed web-based traffic analysis and flow collection tool
    nwipe                                                                                                # Securely erase disks
    obsidian                                                                                             # A powerful knowledge base that works on top of a local folder of plain text Markdown files
    onesixtyone                                                                                          # Fast SNMP Scanner
    openconnect                                                                                          # NetworkManager’s OpenConnect plugin
    openssh                                                                                              #
    openssl                                                                                              # A cryptographic library that implements the SSL and TLS protocols
    openttd                                                                                              # Transport Tycoon Deluxe
    openvpn                                                                                              # NetworkManager's OpenVPN plugin
    oshka                                                                                                # Tool for extracting nested CI/CD supply chains and executing commands
    ostinato                                                                                             # A packet traffic generator and analyzer
    OVMF                                                                                                 # Sample UEFI firmware for QEMU and KVM
    p0f                                                                                                  # Passive network reconnaissance and fingerprinting tool
    p7zip                                                                                                # A new p7zip fork with additional codecs and improvements (forked from https://sourceforge.net/projects/p7zip/)
    pandoc                                                                                               #
    pass                                                                                                 # Stores, retrieves, generates, and synchronizes passwords securely
    pavucontrol                                                                                          # PulseAudio Volume Control
    pciutils                                                                                             # A collection of programs for inspecting and manipulating configuration of PCI devices
    pdfgrep                                                                                              # Commandline utility to search text in PDF files
    pdf-parser                                                                                           # Parse a PDF document
    peco                                                                                                 # Simplistic interactive filtering tool
    pev                                                                                                  # A full-featured, open source, multiplatform command line toolkit to work with PE (Portable Executables) binaries
    photon                                                                                               # RSS/Atom reader with the focus on speed, usability and a bit of unix philosophy
    phrasendrescher                                                                                      # A modular and multi processing pass phrase cracking tool
    pinentry                                                                                             # GnuPG’s interface to passphrase input
    pip-audit                                                                                            # Tool for scanning Python environments for known vulnerabilities
    pixiewps                                                                                             # An offline WPS bruteforce utility
    protonmail-bridge                                                                                    # Use your ProtonMail account with your local e-mail client
    proxify                                                                                              # Proxy tool for HTTP/HTTPS traffic capture
    proxychains                                                                                          # Proxifier for SOCKS proxies
    pstree                                                                                               # Show the set of running processes as a tree
    putty                                                                                                # A Free Telnet/SSH Client
    pwgen                                                                                                # Password generator which creates passwords which can be easily memorized by a human
    pwnat                                                                                                # ICMP NAT to NAT client-server communication
    pwndbg                                                                                               # Exploit Development and Reverse Engineering with GDB Made Easy
    pwntools                                                                                             # CTF framework and exploit development library
    python310                                                                                            #
    python-with-my-packages                                                                              #
    qemu                                                                                                 # A generic and open source machine emulator and virtualizer
    qemu-utils                                                                                           #
    qrcp                                                                                                 # Transfer files over wifi by scanning a QR code from your terminal
    qrencode                                                                                             # C library for encoding data in a QR Code symbol
    radamsa                                                                                              # A general purpose fuzzer
    radare2                                                                                              # unix-like reverse engineering framework and commandline tools
    radare2                                                                                              # unix-like reverse engineering framework and commandline tools
    ranger                                                                                               # File manager with minimalistic curses interface
    rdesktop                                                                                             # Open source client for Windows Terminal Services
    reaverwps                                                                                            #
    reaverwps-t6x                                                                                        #
    recoverjpeg                                                                                          # Recover lost JPEGs and MOV files on a bogus memory card or disk
    redfang                                                                                              # A small proof-of-concept application to find non discoverable bluetooth devices
    redshift                                                                                             # Screen color temperature manager
    redsocks                                                                                             # Transparent redirector of any TCP connection to proxy
    regexploit                                                                                           # Tool to find regular expressions which are vulnerable to ReDoS
    remmina                                                                                              # Remote desktop client written in GTK
    ripgrep                                                                                              # A utility that combines the usability of The Silver Searcher with the raw speed of grep
    ripgrep-all                                                                                          # Ripgrep, but also search in PDFs, E-Books, Office documents, zip, tar.gz, and more
    rizin                                                                                                # UNIX-like reverse engineering framework and command-line toolset.
    routersploit                                                                                         # Exploitation Framework for Embedded Devices
    rshijack                                                                                             # TCP connection hijacker
    rsync                                                                                                # Fast incremental file transfer utility
    rtorrent                                                                                             #
    ruby                                                                                                 # The Ruby language
    rustcat                                                                                              # Port listener and reverse shell
    rustscan                                                                                             # Faster Nmap Scanning with Rust
    rustscan                                                                                             # Faster Nmap Scanning with Rust
    rxvt-unicode                                                                                         # A clone of the well-known terminal emulator rxvt
    safecopy                                                                                             # Data recovery tool for damaged hardware
    safety-cli                                                                                           #
    screen                                                                                               # A window manager that multiplexes a physical terminal
    screenfetch                                                                                          # Fetches system/theme information in terminal for Linux desktop screenshots
    scrot                                                                                                # A command-line screen capture utility
    sddm                                                                                                 # QML based X11 display manager
    secretscanner                                                                                        # Tool to find secrets and passwords in container images and file systems
    siege                                                                                                # HTTP load tester
    signal-desktop                                                                                       # Private, simple, and secure messenger
    simg2img                                                                                             # Tool to convert Android sparse images to raw images
    sipp                                                                                                 # The SIPp testing tool
    sipsak                                                                                               # SIP Swiss army knife
    sipvicious                                                                                           #  Set of tools to audit SIP based VoIP systems
    sish                                                                                                 # HTTP(S)/WS(S)/TCP Tunnels to localhost
    skjold                                                                                               # Tool to Python dependencies against security advisory databases
    slack                                                                                                # Desktop client for Slack
    sleuthkit                                                                                            # A forensic/data recovery tool
    slowlorust                                                                                           # Lightweight slowloris (HTTP DoS) tool
    sn0int                                                                                               # Semi-automatic OSINT framework and package manager
    snallygaster                                                                                         # Tool to scan for secret files on HTTP servers
    sngrep                                                                                               # A tool for displaying SIP calls message flows from terminal
    sniffglue                                                                                            # Secure multithreaded packet sniffer
    snmpcheck                                                                                            # SNMP enumerator
    socat                                                                                                # Utility for bidirectional data transfer between two independent data channels
    spike                                                                                                # A RISC-V ISA Simulator
    sqlite-web                                                                                           # Web-based SQLite database browser
    sqlmap                                                                                               # Automatic SQL injection and database takeover tool
    srm                                                                                                  # Delete files securely
    ssb                                                                                                  # Tool to bruteforce SSH server
    ssdeep                                                                                               # A program for calculating fuzzy hashes
    ssh-audit                                                                                            # Tool for ssh server auditing
    sshchecker                                                                                           # Dedicated SSH brute-forcing tool
    sshfs                                                                                                #
    ssh-mitm                                                                                             # Tool for SSH security audits
    sshping                                                                                              # Measure character-echo latency and bandwidth for an interactive ssh session
    ssldump                                                                                              # An SSLv3/TLS network protocol analyzer
    sslh                                                                                                 # Applicative Protocol Multiplexer (e.g. share SSH and HTTPS on the same port)
    sslsplit                                                                                             # Transparent SSL/TLS interception
    steampipe                                                                                            # select * from cloud;
    stegseek                                                                                             # Tool to crack steganography
    stockfish                                                                                            # Strong open source chess engine
    stunnel                                                                                              # Universal tls/ssl wrapper
    subfinder                                                                                            # Subdomain discovery tool
    subfinder                                                                                            # Subdomain discovery tool
    subjs                                                                                                # Fetcher for Javascript files
    subzerod                                                                                             # Python module to help with the enumeration of subdomains
    swaggerhole                                                                                          # Tool to searching for secret on swaggerhub
    swaks                                                                                                # A featureful, flexible, scriptable, transaction-oriented SMTP test tool
    sx-go                                                                                                # Command-line network scanner
    tcpflow                                                                                              # TCP stream extractor
    tcpreplay                                                                                            # A suite of utilities for editing and replaying network traffic
    teler                                                                                                # Real-time HTTP Intrusion Detection
    terraform                                                                                            #
    testdisk                                                                                             # Data recovery utilities
    testssl                                                                                              # CLI tool to check a server's TLS/SSL capabilities
    texlive.combined.scheme-full                                                                         #
    tfsec                                                                                                # Static analysis powered security scanner for terraform code
    thc-hydra                                                                                            # A very fast network logon cracker which support many different services
    thc-hydra                                                                                            # A very fast network logon cracker which support many different services
    thefuck                                                                                              # Magnificent app which corrects your previous console command
    tig                                                                                                  # Text-mode interface for git
    tldr                                                                                                 # Simplified and community-driven man pages
    tmux                                                                                                 # Terminal multiplexer
    tor                                                                                                  # Anonymizing overlay network
    tracee                                                                                               # Linux Runtime Security and Forensics using eBPF
    traitor                                                                                              # Automatic Linux privilege escalation
    trivy                                                                                                # A simple and comprehensive vulnerability scanner for containers, suitable for CI
    trivy                                                                                                # A simple and comprehensive vulnerability scanner for containers, suitable for CI
    truecrack                                                                                            # TrueCrack is a brute-force password cracker for TrueCrypt volumes. It works on Linux and it is optimized for Nvidia Cuda technology.
    trueseeing                                                                                           # Non-decompiling Android vulnerability scanner
    trufflehog                                                                                           # Searches through git repositories for high entropy strings and secrets, digging deep into commit history
    tsung                                                                                                # A high-performance benchmark framework for various protocols including HTTP, XMPP, LDAP, etc
    twmn                                                                                                 # A notification system for tiling window managers
    ubertooth                                                                                            # Open source wireless development platform suitable for Bluetooth experimentation
    uddup                                                                                                # Tool for de-duplication URLs
    udptunnel                                                                                            # Tunnels TCP over UDP packets
    unrar                                                                                                # Utility for RAR archives
    unzip                                                                                                # An extraction utility for archives compressed in .zip format
    urlhunter                                                                                            # Recon tool that allows searching shortened URLs
    usbutils                                                                                             # Tools for working with USB devices, such as lsusb
    utillinux                                                                                            #
    valgrind                                                                                             # Debugging and profiling tool suite
    vegeta                                                                                               # Versatile HTTP load testing tool
    velero                                                                                               #
    vim                                                                                                  #
    virt-manager                                                                                         # Desktop user interface for managing virtual machines
    vlc                                                                                                  # Cross-platform media player and streaming server
    vmware-horizon-client                                                                                # Allows you to connect to your VMware Horizon virtual desktop
    volatility3                                                                                          # Volatile memory extraction frameworks
    vue                                                                                                  # Visual Understanding Environment - mind mapping software
    vulnix                                                                                               # NixOS vulnerability scanner
    w3m                                                                                                  # A text-mode web browser
    wad                                                                                                  # Tool for detecting technologies used by web applications
    wavemon                                                                                              # Ncurses-based monitoring application for wireless network devices
    waybar                                                                                               # Highly customizable Wayland bar for Sway and Wlroots based compositors
    wayvnc                                                                                               # A VNC server for wlroots based Wayland compositors
    wbox                                                                                                 # A simple HTTP benchmarking tool
    wget                                                                                                 # Tool for retrieving files using HTTP, HTTPS, and FTP
    whispers                                                                                             # Tool to identify hardcoded secrets in static structured text
    whois                                                                                                # Intelligent WHOIS client from Debian
    wifite2                                                                                              # Rewrite of the popular wireless network auditor, wifite
    win-virtio                                                                                           # Windows VirtIO Drivers
    wipe                                                                                                 # Secure file wiping utility
    wireguard-tools                                                                                      # Tools for the WireGuard secure network tunnel
    wireshark-qt                                                                                         #
    witness                                                                                              # A pluggable framework for software supply chain security.
    woeusb                                                                                               # Create bootable USB disks from Windows ISO images
    wprecon                                                                                              # WordPress vulnerability recognition tool
    wpscan                                                                                               # Black box WordPress vulnerability scanner
    wpscan                                                                                               # Black box WordPress vulnerability scanner
    wstunnel                                                                                             #
    wuzz                                                                                                 # Interactive cli tool for HTTP inspection
    wuzz                                                                                                 # Interactive cli tool for HTTP inspection
    x11docker                                                                                            # Run graphical applications with Docker
    x11vnc                                                                                               # A VNC server connected to a real X11 screen
    xcalib                                                                                               # A tiny monitor calibration loader for X and MS-Windows
    xh                                                                                                   # Friendly and fast tool for sending HTTP requests
    xidel                                                                                                # Command line tool to download and extract data from HTML/XML pages as well as JSON APIs
    xkb-switch-i3                                                                                        # Switch your X keyboard layouts from the command line(i3 edition)
    xlockmore                                                                                            # Screen locker for the X Window System
    xorex                                                                                                # XOR Key Extractor
    xorg.xbacklight                                                                                      #
    xorg.xeyes                                                                                           #
    xorg.xmodmap                                                                                         #
    xortool                                                                                              # Tool to analyze multi-byte XOR cipher
    xwayland                                                                                             #
    yara                                                                                                 # The pattern matching swiss knife for malware researchers
    yersinia                                                                                             # A framework for layer 2 attacks
    youtube-dl                                                                                           # Emacs youtube-dl download manager
    zap                                                                                                  # Java application for web penetration testing
    zeek                                                                                                 # Network analysis framework much different from a typical IDS
    zip                                                                                                  # Compressor/archiver for creating and modifying zipfiles
    zkar                                                                                                 # Java serialization protocol analysis tool
    zlib                                                                                                 # Lossless data-compression library
    zmap                                                                                                 # Fast single packet network scanner designed for Internet-wide network surveys
    zoom-us                                                                                              # zoom.us video conferencing application
    zotero                                                                                               # Collect, organize, cite, and share your research sources
    zsh                                                                                                  # The Z shell
    zsh-autosuggestions                                                                                  # Fish shell autosuggestions for Zsh
    zsh-completions                                                                                      # Additional completion definitions for zsh
    zsh-powerlevel10k                                                                                    # A fast reimplementation of Powerlevel9k ZSH theme
    zsh-syntax-highlighting                                                                              # Fish shell like syntax highlighting for Zsh
    zzuf                                                                                                 # Transparent application input fuzzer
  ];
}
