{ config, pkgs, lib, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    (pkgs.writeShellScriptBin "qemu-system-x86_64-uefi" ''
      qemu-system-x86_64 \
        -bios ${pkgs.OVMF.fd}/FV/OVMF.fd \
        "$@"
    '')
    abootimg                                                                                             # Manipulate Android Boot Images
    #adreaper                                                                                             # Enumeration tool for Windows Active Directories
    afflib                                                                                               # Advanced forensic format library
    #afl                                                                                                  # Powerful fuzzer via genetic algorithms and instrumentation
    aflplusplus                                                                                          #
    aha                                                                                                  # ANSI HTML Adapter
    aiodnsbrute                                                                                          # DNS brute force utility
    aircrack-ng                                                                                          # Wireless encryption cracking tools
    airgeddon                                                                                            # Multi-use TUI to audit wireless networks
    alacritty                                                                                            # A cross-platform, GPU-accelerated terminal emulator
    alacritty-theme                                                                                      # Collection of Alacritty color schemes
    alsa-utils                                                                                           # ALSA, the Advanced Linux Sound Architecture utils
    amass                                                                                                # In-Depth DNS Enumeration and Network Mapping
    androguard                                                                                           # Tool and Python library to interact with Android Files
    android-tools                                                                                        # Android SDK platform tools
    anevicon                                                                                             # UDP-based load generator
    ansible                                                                                              # Radically simple IT automation
    antimicrox                                                                                           # GUI for mapping keyboard and mouse controls to a gamepad
    apkeep                                                                                               # A command-line tool for downloading APK files from various sources
    apkleaks                                                                                             # Scanning APK file for URIs, endpoints and secrets
    #apktool                                                                                              # A tool for reverse engineering Android apk files
    appimage-run                                                                                         #
    aria                                                                                                 #
    arping                                                                                               # Broadcasts a who-has ARP packet on the network and prints answers
    arp-scan                                                                                             # ARP scanning and fingerprinting tool
    arsenal                                                                                              # Tool to generate commands for security and network tools
    asciinema                                                                                            # Terminal session recorder and the best companion of asciinema.org
    asn                                                                                                  # OSINT command line tool for investigating network data
    at                                                                                                   # The classical Unix `at' job scheduling command
    atftp                                                                                                # Advanced tftp tools
    authoscope                                                                                           # Scriptable network authentication cracker
    autokey                                                                                              # Desktop automation utility for Linux and X11
    autossh                                                                                              # Automatically restart SSH sessions and tunnels
    awscli                                                                                               # Unified tool to manage your AWS services
    #azure-cli                                                                                            # Next generation multi-platform command line experience for Azure
    badchars                                                                                             # HEX badchar generator for different programming languages
    bandwhich                                                                                            # A CLI utility for displaying current network utilization
    bc                                                                                                   # GNU software calculator
    bettercap                                                                                            # A man in the middle tool
    bingrep                                                                                              # Greps through binaries from various OSs and architectures, and colors them
    bintools                                                                                             # Tools for manipulating binaries (linker, assembler, etc.) (wrapper script)
    binwalk                                                                                              # A tool for searching a given binary image for embedded files
    #boofuzz                                                                                              # Network protocol fuzzing tool
    bore-cli                                                                                             # Rust tool to create TCP tunnels
    brakeman                                                                                             # Static analysis security scanner for Ruby on Rails
    brillo                                                                                               # Backlight and Keyboard LED control tool
    bruno                                                                                                # Open-source IDE For exploring and testing APIs
    #bruteforce-luks                                                                                      # Cracks passwords of LUKS encrypted volumes
    brutespray                                                                                           # Tool to do brute-forcing from Nmap output
    bully                                                                                                # Retrieve WPA/WPA2 passphrase from a WPS enabled access point
    burpsuite                                                                                            # An integrated platform for performing security testing of web applications
    cabextract                                                                                           # Free Software for extracting Microsoft cabinet files
    calibre                                                                                              # Comprehensive e-book software
    #cameradar                                                                                            # RTSP stream access tool
    #cantoolz                                                                                             # Black-box CAN network analysis framework
    cardpeek                                                                                             # A tool to read the contents of ISO7816 smart cards
    cargo-audit                                                                                          # Audit Cargo.lock files for crates with security vulnerabilities
    cariddi                                                                                              # Crawler for URLs and endpoints
    cassowary                                                                                            # Modern cross-platform HTTP load-testing tool written in Go
    certipy                                                                                              # Tool to enumerate and abuse misconfigurations in Active Directory Certificate Services
    #cfripper                                                                                             # Tool for analysing CloudFormation templates
    cgdb                                                                                                 # A curses interface to gdb
    chain-bench                                                                                          # An open-source tool for auditing your software supply chain stack for security compliance based on a new CIS Software Supply Chain benchmark
    changetower                                                                                          # Tools to watch for webppage changes
    checkip                                                                                              # CLI tool that checks an IP address using various public services
    #checkov                                                                                              # Static code analysis tool for infrastructure-as-code
    checksec                                                                                             # Tool for checking security bits on executables
    cherrytree                                                                                           # An hierarchical note taking application
    chipsec                                                                                              # Platform Security Assessment Framework
    chisel                                                                                               # TCP/UDP tunnel over HTTP
    chkrootkit                                                                                           # Locally checks for signs of a rootkit
    chntpw                                                                                               # An utility to reset the password of any user that has a valid local account on a Windows system
    chopchop                                                                                             # CLI to search for sensitive services/files/folders
    chroma                                                                                               # A general purpose syntax highlighter in pure Go
    chromedriver                                                                                         # A WebDriver server for running Selenium tests on Chrome
    chromium                                                                                             #
    clair                                                                                                # Vulnerability Static Analysis for Containers
    clamav                                                                                               # Antivirus engine designed for detecting Trojans, viruses, malware and other malicious threats
    cliam                                                                                                # Cloud agnostic IAM permissions enumerator
    clockify                                                                                             # Free time tracker and timesheet app that lets you track work hours across projects
    cloudbrute                                                                                           # Cloud enumeration tool
    cloudlist                                                                                            # Tool for listing assets from multiple cloud providers
    #codeql                                                                                               # Semantic code analysis engine
    conda                                                                                                # Conda is a package manager for Python
    connman                                                                                              #
    connman-gtk                                                                                          # GTK GUI for Connman
    corkscrew                                                                                            # A tool for tunneling SSH through HTTP proxies
    corsair                                                                                              #
    cowpatty                                                                                             # Offline dictionary attack against WPA/WPA2 networks
    credential-detector                                                                                  # Tool to detect potentially hard-coded credentials
    croc                                                                                                 # Easily and securely send things from one computer to another
    #crowbar                                                                                              # A brute forcing tool that can be used during penetration tests
    crunch                                                                                               # Wordlist generator
    cudaPackages.cudatoolkit                                                                             # A compiler for NVIDIA GPUs, math libraries, and tools
    cudatoolkit                                                                                          # A compiler for NVIDIA GPUs, math libraries, and tools
    cups-brother-hl3140cw                                                                                #
    daemon                                                                                               # Turns other processes into daemons
    dalfox                                                                                               # Tool for analysing parameter and XSS scanning
    dbeaver-bin                                                                                          # Universal SQL Client for developers, DBA and analysts. Supports MySQL, PostgreSQL, MariaDB, SQLite, and more
    dcfldd                                                                                               # An enhanced version of GNU dd
    ddosify                                                                                              # High-performance load testing tool, written in Golang
    ddrescue                                                                                             # GNU ddrescue, a data recovery tool
    ddrescueview                                                                                         # A tool to graphically examine ddrescue mapfiles
    #deepsea                                                                                              # Phishing tool for red teams and pentesters
    detect-secrets                                                                                       # An enterprise friendly way of detecting and preventing secrets in code
    dex2jar                                                                                              # Tools to work with android .dex and java .class files
    dhcpdump                                                                                             # A tool for visualization of DHCP packets as recorded and output by tcpdump to analyze DHCP server responses
    diff-pdf                                                                                             # Simple tool for visually comparing two PDF files
    dirb                                                                                                 # A web content scanner
    discord                                                                                              # All-in-one cross-platform voice and text chat for gamers
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
    dockle                                                                                               # Container Image Linter for Security
    dockstarter                                                                                          # DockSTARTer helps you get started with running apps in Docker
    dontgo403                                                                                            # Tool to bypass 40X response codes
    doona                                                                                                # A fork of the Bruteforce Exploit Detector Tool (BED)
    dosfstools                                                                                           # Utilities for creating and checking FAT and VFAT file systems
    dotnet-sdk                                                                                           # .NET SDK 6.0.406
    driftnet                                                                                             # Watches network traffic, and picks out and displays JPEG and GIF images for display
    drill                                                                                                # HTTP load testing application inspired by Ansible syntax
    dsniff                                                                                               # collection of tools for network auditing and penetration testing
    #eclipses.eclipse-java                                                                                # Eclipse IDE for Java Developers
    electrum                                                                                             # A lightweight Bitcoin wallet
    enum4linux                                                                                           # A tool for enumerating information from Windows and Samba systems
    enum4linux-ng                                                                                        # Windows/Samba enumeration tool
    erosmb                                                                                               # SMB network scanner
    esptool                                                                                              # ESP8266 and ESP32 serial bootloader utility
    ettercap                                                                                             # Comprehensive suite for man in the middle attacks
    evil-winrm                                                                                           # WinRM shell for hacking/pentesting
    exiv2                                                                                                # A library and command-line utility to manage image metadata
    ext4magic                                                                                            # Recover / undelete files from ext3 or ext4 partitions
    extrude                                                                                              # Tool to analyse binaries for missing security features
    extundelete                                                                                          # Utility that can recover deleted files from an ext3 or ext4 partition
    fcrackzip                                                                                            # zip password cracker, similar to fzc, zipcrack and others
    ferdium                                                                                              # All your services in one place built by the community
    feroxbuster                                                                                          # Fast, simple, recursive content discovery tool
    ffmpeg                                                                                               # Bindings for the ffmpeg libraries
    ffuf                                                                                                 # Fast web fuzzer written in Go
    fierce                                                                                               # DNS reconnaissance tool for locating non-contiguous IP space
    filezilla                                                                                            # Graphical FTP, FTPS and SFTP client
    findomain                                                                                            # The fastest and cross-platform subdomain enumerator
    firecracker                                                                                          # Secure, fast, minimal micro-container virtualization
    firectl                                                                                              # A command-line tool to run Firecracker microVMs
    firefox                                                                                              #
    flac                                                                                                 # Library and tools for encoding and decoding the FLAC lossless audio file format
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
    gdb                                                                                                  # The GNU Project debugger
    gdbgui                                                                                               # A browser-based frontend for GDB
    gef                                                                                                  # A modern experience for GDB with advanced debugging features for exploit developers & reverse engineers
    genymotion                                                                                           # Fast and easy Android emulation
    ghost                                                                                                # Android post-exploitation framework
    #gimp                                                                                                 # The GNU Image Manipulation Program
    git-crypt                                                                                            # Transparent file encryption in git
    gitlab-runner                                                                                        # GitLab Runner the continuous integration executor of GitLab
    gitleaks                                                                                             # Scan git repos (or files) for secrets
    glab                                                                                                 # An open-source GitLab command line tool
    glances                                                                                              # Cross-platform curses-based monitoring tool
    glib                                                                                                 # C library of programming buildings blocks
    glibc                                                                                                # The GNU C Library
    gnupg                                                                                                # PHP wrapper for GpgME library that provides access to GnuPG
    go365                                                                                                # Office 365 enumeration tool
    gobuster                                                                                             # Tool used to brute-force URIs, DNS subdomains, Virtual Host names on target web servers
    godot_4                                                                                              # Free and Open Source 2D and 3D game engine
    gokart                                                                                               # Static analysis tool for securing Go code
    gomapenum                                                                                            # Tools for user enumeration and password bruteforce
    goreplay                                                                                             # Open-source tool for capturing and replaying live HTTP traffic
    gospider                                                                                             # Fast web spider written in Go
    gotestwaf                                                                                            # Tool for API and OWASP attack simulation
    gpa                                                                                                  # Graphical user interface for the GnuPG
    gqrx                                                                                                 # Software defined radio (SDR) receiver
    gqrx-gr-audio                                                                                        # Software defined radio (SDR) receiver
    grepcidr                                                                                             # Filter IPv4 and IPv6 addresses matching CIDR patterns
    grim                                                                                                 # Grab images from a Wayland compositor
    grype                                                                                                # Vulnerability scanner for container images and filesystems
    gzrt                                                                                                 # The gzip Recovery Toolkit
    hachoir                                                                                              # Python library to view and edit a binary stream
    hakrawler                                                                                            # Web crawler for the discovery of endpoints and assets
    hans                                                                                                 # Tunnel IPv4 over ICMP
    hashcat                                                                                              # Fast password cracker
    hashcat-utils                                                                                        # Small utilities that are useful in advanced password cracking
    hashdeep                                                                                             # A set of cross-platform tools to compute hashes
    hcxtools                                                                                             # Tools for capturing wlan traffic and conversion to hashcat and John the Ripper formats
    headscale                                                                                            # An open source, self-hosted implementation of the Tailscale control server
    hey                                                                                                  # HTTP load generator, ApacheBench (ab) replacement
    hivex                                                                                                # Windows registry hive extraction library
    honeytrap                                                                                            # Advanced Honeypot framework
    honggfuzz                                                                                            #
    horst                                                                                                # Small and lightweight IEEE802.11 wireless LAN analyzer with a text interface
  
    #httpdump                                                                                             # Parse and display HTTP traffic from network device or pcap file
    httptunnel                                                                                           # Creates a bidirectional virtual data connection tunnelled in HTTP requests
    httpx                                                                                                # Fast and multi-purpose HTTP toolkit
    hyper                                                                                                # A terminal built on web technologies
    ike-scan                                                                                             # Tool to discover, fingerprint and test IPsec VPN servers
    imagemagick                                                                                          #
    inkscape                                                                                             # Vector graphics editor
    inotify-tools                                                                                        #
    input-leap                                                                                           # Open-source KVM software
    #inql                                                                                                 # Security testing tool for GraphQL
    iodine                                                                                               # NetworkManager's iodine plugin
    ipscan                                                                                               # Fast and friendly network scanner
    iw                                                                                                   # Tool to use nl80211
    jadx                                                                                                 # Dex to Java decompiler
    jaeles                                                                                               # Tool for automated Web application testing
    jd-gui                                                                                               # Fast Java Decompiler with powerful GUI
    jdk                                                                                                  #
    john                                                                                                 # John the Ripper password cracker
    junkie                                                                                               # Deep packet inspection swiss-army knife
    k6                                                                                                   # A modern load testing tool, using Go and JavaScript
    kaitai-struct-compiler                                                                               # Compiler to generate binary data parsers
    kalibrate-hackrf                                                                                     # Calculate local oscillator frequency offset in hackrf devices
    kalibrate-rtl                                                                                        # Calculate local oscillator frequency offset in RTL-SDR devices
    kdigger                                                                                              # An in-pod context discovery tool for Kubernetes penetration testing
    keepassxc                                                                                            #
    kerbrute                                                                                             # Kerberos bruteforce utility
    khal                                                                                                 # CLI calendar application
    kind                                                                                                 # Kubernetes IN Docker - local clusters for testing Kubernetes
    kismet                                                                                               # Wireless network sniffer
    kiterunner                                                                                           # Contextual content discovery tool
    kiwix                                                                                                # An offline reader for Web content
    knockpy                                                                                              # Tool to scan subdomains
    kubeaudit                                                                                            # Audit tool for Kubernetes
    kubescape                                                                                            # Tool for testing if Kubernetes is deployed securely
    kube-score                                                                                           # Kubernetes object analysis with recommendations for improved reliability and security
    kustomize                                                                                            # Customization of kubernetes YAML configurations
    ldeep                                                                                                # In-depth LDAP enumeration utility
    lens                                                                                                 # The Kubernetes IDE
    lftp                                                                                                 # A file transfer program supporting a number of network protocols
    libfreefare                                                                                          # The libfreefare project aims to provide a convenient API for MIFARE card manipulations
    libgcc        # GNU Compiler Collection, version 12.3.0
    libgccjit                                                                                            # GNU Compiler Collection
    libglibutil                                                                                          # Library of glib utilities
    libisoburn                                                                                           # Enables creation and expansion of ISO-9660 filesystems on CD/DVD/BD
    logseq                                                                                               # Organize and share your personal knowledge base
    lsof                                                                                                 # A tool to list open files
    lynis                                                                                                # Security auditing tool for Linux, macOS, and UNIX-based systems
    j4-dmenu-desktop                                                                                     # A wrapper for dmenu that recognize .desktop files
    macchanger                                                                                           # A utility for viewing/manipulating the MAC address of network interfaces
    mariadb                                                                                              # An enhanced, drop-in replacement for MySQL
    masscan                                                                                              # Fast scan of the Internet
    medusa                                                                                               # A speedy, parallel, and modular, login brute-forcer
    metabigor                                                                                            # Tool to perform OSINT tasks
    mfcuk                                                                                                # MiFare Classic Universal toolKit
    mfoc                                                                                                 # Mifare Classic Offline Cracker
    mimeo                                                                                                # Open files by MIME-type or file name using regular expressions
    minecraft
    minikube                                                                                             # A tool that makes it easy to run Kubernetes locally
    mitmproxy                                                                                            # Man-in-the-middle proxy
    mkcert                                                                                               # A simple tool for making locally-trusted development certificates
    monero-gui                                                                                           # Private, secure, untraceable currency
    mongoaudit                                                                                           # MongoDB auditing and pentesting tool
    mono                                                                                                 # Cross platform, open source .NET development framework
    monsoon                                                                                              # Fast HTTP enumerator
    mplayer                                                                                              # A movie player that supports many video formats
    mpv                                                                                                  # General-purpose media player, fork of MPlayer and mplayer2
    mubeng                                                                                               # Proxy checker and IP rotator
    multimon-ng                                                                                          # Multimon is a digital baseband audio protocol decoder
    naabu                                                                                                # Fast SYN/CONNECT port scanner
    nasty                                                                                                # Recover the passphrase of your PGP or GPG-key
    navi                                                                                                 # An interactive cheatsheet tool for the command-line and application launchers TODO
    nbtscanner                                                                                           # NetBIOS scanner written in Rust
    nchat                                                                                                # Terminal-based chat client with support for Telegram and WhatsApp
    ncrack                                                                                               # Network authentication tool
    neocomp                                                                                              # A fork of Compton, a compositor for X11
    net-snmp                                                                                             # Clients and server for the SNMP network monitoring protocol
    netdiscover                                                                                          # A network address discovering tool, developed mainly for those wireless networks without dhcp server, it also works on hub/switched networks
    netsniff-ng                                                                                          # Swiss army knife for daily Linux network plumbing
    networkmanager                                                                                       # Network configuration and management tool
    ngrep                                                                                                # Network packet analyzer
    nmap-formatter                                                                                       # Tool that allows you to convert nmap output
    nth                                                                                                  #
    ntlmrecon                                                                                            # Information enumerator for NTLM authentication enabled web endpoints
    ntopng                                                                                               # High-speed web-based traffic analysis and flow collection tool
    nuclear                                                                                              # Streaming music player that finds free music for you
    nuclei                                                                                               # Tool for configurable targeted scanning
    #nvidia-docker                                                                                        # NVIDIA container runtime for Docker
    #nvidia-container-toolkit                                                                             # NVIDIA Container Toolkit
    nwipe                                                                                                # Securely erase disks
    nzbget        # A command line tool for downloading files from news servers
    obs-studio                                                                                           # Free and open source software for video recording and live streaming
    obsidian                                                                                             # A powerful knowledge base that works on top of a local folder of plain text Markdown files
    ollama                                                                                               # Get up and running with large language models locally
    onesixtyone                                                                                          # Fast SNMP Scanner
    open-interpreter                                                                                     # OpenAI's Code Interpreter in your terminal, running locally
    openfortivpn                                                                                         # Client for PPP+SSL VPN tunnel services
    #openshot-qt                                                                                          # Free, open-source video editor
    openttd                                                                                              # Transport Tycoon Deluxe
    oshka                                                                                                # Tool for extracting nested CI/CD supply chains and executing commands
    ostinato                                                                                             # A packet traffic generator and analyzer
    OVMF                                                                                                 # Sample UEFI firmware for QEMU and KVM
    p0f                                                                                                  # Passive network reconnaissance and fingerprinting tool
    pandoc                                                                                               #
    parted                                                                                               # Create, destroy, resize, check, and copy partitions
    pass                                                                                                 # Stores, retrieves, generates, and synchronizes passwords securely
    pavucontrol                                                                                          # PulseAudio Volume Control
    pdfgrep                                                                                              # Commandline utility to search text in PDF files
    pdf-parser                                                                                           # Parse a PDF document
    pev                                                                                                  # A full-featured, open source, multiplatform command line toolkit to work with PE (Portable Executables) binaries
    php                                                                                                  # An HTML-embedded scripting language
    phrasendrescher                                                                                      # A modular and multi processing pass phrase cracking tool
    pinentry                                                                                             # GnuPG’s interface to passphrase input
    #pip-audit                                                                                            # Tool for scanning Python environments for known vulnerabilities
    pixiewps                                                                                             # An offline WPS bruteforce utility
    popsicle                                                                                             # Multiple USB File Flasher
    portaudio                                                                                            # Portable cross-platform Audio API
    postman                                                                                              # API Development Environment
    powershell                                                                                           # Powerful cross-platform (Windows, Linux, and macOS) shell and scripting language based on .NET
    putty                                                                                                # A Free Telnet/SSH Client
    pwnat                                                                                                # ICMP NAT to NAT client-server communication
    pwndbg                                                                                               # Exploit Development and Reverse Engineering with GDB Made Easy
    pwntools                                                                                             # CTF framework and exploit development library
    qbittorrent                                                                                          # Featureful free software BitTorrent client
    qpaeq                                                                                                # An equalizer interface for pulseaudio's equalizer sinks
    quickemu                                                                                             # Quickly create and run optimised Windows, macOS and Linux desktop virtual machines
    radamsa                                                                                              # A general purpose fuzzer
    radare2                                                                                              # unix-like reverse engineering framework and commandline tools
    rclone                                                                                               # Command line program to sync files and directories to and from major cloud storage
    rdesktop                                                                                             # Open source client for Windows Terminal Services
    reaverwps                                                                                            #
    reaverwps-t6x                                                                                        #
    recoverjpeg                                                                                          # Recover lost JPEGs and MOV files on a bogus memory card or disk
    redfang                                                                                              # A small proof-of-concept application to find non discoverable bluetooth devices
    regexploit                                                                                           # Tool to find regular expressions which are vulnerable to ReDoS
    rehex                                                                                                # Reverse Engineers' Hex Editor
    remmina                                                                                              # Remote desktop client written in GTK
    rizin                                                                                                # UNIX-like reverse engineering framework and command-line toolset
    rke                                                                                                  # An extremely simple, lightning fast Kubernetes distribution that runs entirely within containers
    #rofi                                                                                                 # Window switcher, run dialog and dmenu replacement
    #rofi-calc                                                                                            # Do live calculations in rofi!
    #rofi-emoji                                                                                           # An emoji selector plugin for Rofi
    #routersploit                                                                                         # Exploitation Framework for Embedded Devices
    rshijack                                                                                             # TCP connection hijacker
    rtl-sdr                                                                                              # Turns your Realtek RTL2832 based DVB dongle into a SDR receiver
    rustcat                                                                                              # Port listener and reverse shell
    rustscan                                                                                             # Faster Nmap Scanning with Rust
    rxvt-unicode                                                                                         # A clone of the well-known terminal emulator rxvt
    safecopy                                                                                             # Data recovery tool for damaged hardware
    samba                                                                                                # The standard Windows interoperability suite of programs for Linux and Unix
    scrcpy                                                                                               # Display and control Android devices over USB or TCP/IP
    scrot                                                                                                # A command-line screen capture utility
    #safety-cli                                                                                           #
    sddm                                                                                                 # QML based X11 display manager
    SDL2                                                                                                 # A cross-platform multimedia library
    secretscanner                                                                                        # Tool to find secrets and passwords in container images and file systems
    semgrep                                                                                              # Lightweight static analysis for many languages - cli
    siege                                                                                                # HTTP load tester
    signal-desktop                                                                                       # Private, simple, and secure messenger
    simg2img                                                                                             # Tool to convert Android sparse images to raw images
    sipp                                                                                                 # The SIPp testing tool
    sipsak                                                                                               # SIP Swiss army knife
    sipvicious                                                                                           # Set of tools to audit SIP based VoIP systems
    sish                                                                                                 # HTTP(S)/WS(S)/TCP Tunnels to localhost
    #skjold                                                                                               # Tool to Python dependencies against security advisory databases
    slack                                                                                                # Desktop client for Slack
    sleuthkit                                                                                            # A forensic/data recovery tool
    slowlorust                                                                                           # Lightweight slowloris (HTTP DoS) tool
    sn0int                                                                                               # Semi-automatic OSINT framework and package manager
    snallygaster                                                                                         # Tool to scan for secret files on HTTP servers
    sngrep                                                                                               # A tool for displaying SIP calls message flows from terminal
    sniffglue                                                                                            # Secure multithreaded packet sniffer
    snmpcheck                                                                                            # SNMP enumerator
    snyk                                                                                                 # Scans and monitors projects for security vulnerabilities
    sonar-scanner-cli                                                                                    # SonarQube Scanner used to start code analysis
    sox                                                                                                  # Sample Rate Converter for audio
    sqlite                                                                                               # A self-contained, serverless, zero-configuration, transactional SQL database engine
    sqlmap                                                                                               # Automatic SQL injection and database takeover tool
    srm                                                                                                  # Delete files securely
    #ssb                                                                                                  # Tool to bruteforce SSH server
    ssdeep                                                                                               # A program for calculating fuzzy hashes
    ssh-audit                                                                                            # Tool for ssh server auditing
    sshchecker                                                                                           # Dedicated SSH brute-forcing tool
    #ssh-mitm                                                                                             # Tool for SSH security audits
    sshping                                                                                              # Measure character-echo latency and bandwidth for an interactive ssh session
    ssldump                                                                                              # An SSLv3/TLS network protocol analyzer
    sslsplit                                                                                             # Transparent SSL/TLS interception
    steam                                                                                                # A digital distribution platform
    steampipe                                                                                            # select * from cloud;
    stegseek                                                                                             # Tool to crack steganography
    #step-ca                                                                                              # A private certificate authority
    stockfish                                                                                            # Strong open source chess engine
    subfinder                                                                                            # Subdomain discovery tool
    subjs                                                                                                # Fetcher for Javascript files
    subzerod                                                                                             # Python module to help with the enumeration of subdomains
    #swaggerhole                                                                                          # Tool to searching for secret on swaggerhub
    swaks                                                                                                # A featureful, flexible, scriptable, transaction-oriented SMTP test tool
    sx-go                                                                                                # Command-line network scanner
    tcpflow                                                                                              # TCP stream extractor
    tcpreplay                                                                                            # A suite of utilities for editing and replaying network traffic
    tdesktop                                                                                             # Telegram Desktop messaging app
    termcolor                                                                                            # Header-only C++ library for printing colored messages
    #teams                                                                                                # Microsoft Teams
    tfsec                                                                                                # Static analysis powered security scanner for terraform code
    teler                                                                                                # Real-time HTTP Intrusion Detection
    testssl                                                                                              # CLI tool to check a server's TLS/SSL capabilities
    tfsec                                                                                                # Static analysis powered security scanner for terraform code
    thc-hydra                                                                                            # A very fast network logon cracker which support many different services
    ticker                                                                                               # Terminal stock ticker with live updates and position tracking
    tor-browser-bundle-bin                                                                               # Tor Browser Bundle built by torproject.org
    #tracee                                                                                               # Linux Runtime Security and Forensics using eBPF
    traitor                                                                                              # Automatic Linux privilege escalation
    trilium-desktop                                                                                      # Note taking application with focus on building large personal knowledge bases
    trivy                                                                                                # A simple and comprehensive vulnerability scanner for containers, suitable for CI
    truecrack                                                                                            # TrueCrack is a brute-force password cracker for TrueCrypt volumes
    #trueseeing                                                                                           # Non-decompiling Android vulnerability scanner
    trufflehog                                                                                           # Searches through git repositories for high entropy strings and secrets
    tsung                                                                                                # A high-performance benchmark framework for various protocols
    twingate                                                                                             # Twingate Client
    ubertooth                                                                                            # Open source wireless development platform suitable for Bluetooth experimentation
    uddup                                                                                                # Tool for de-duplication URLs
    unar                                                                                                 # An archive unpacker program
    urh                                                                                                  # Universal Radio Hacker: investigate wireless protocols like a boss
    urlhunter                                                                                            # Recon tool that allows searching shortened URLs
    valgrind                                                                                             # Debugging and profiling tool suite
    #vault                                                                                                # A tool for managing secrets 
    vdirsyncer                                                                                           # Synchronize calendars and contacts
    vegeta                                                                                               # Versatile HTTP load testing tool
    velero                                                                                               #
    ventoy-bin                                                                                           # An open source tool to create bootable USB drive for ISO/WIM/IMG/VHD(x)/EFI files
    #vmware-workstation                                                                                   # Industry standard desktop hypervisor for x86-64 architecture
    virt-manager                                                                                         # Desktop user interface for managing virtual machines
    volatility3                                                                                          # Volatile memory extraction frameworks
    vscode                                                                                               # Open source source code editor developed by Microsoft for Windows, Linux and macOS
    vue                                                                                                  # Visual Understanding Environment - mind mapping software
    vulnix                                                                                               # NixOS vulnerability scanner
    wad                                                                                                  # Tool for detecting technologies used by web applications
    warpd                                                                                                # A modal keyboard driven interface for mouse manipulation
    wavemon                                                                                              # Ncurses-based monitoring application for wireless network devices
    waybar                                                                                               # Highly customizable Wayland bar for Sway and Wlroots based compositors
    wayvnc                                                                                               # A VNC server for wlroots based Wayland compositors
    wbox                                                                                                 # A simple HTTP benchmarking tool
    welle-io                                                                                             # A DAB/DAB+ Software Radio
    whispers                                                                                             # Tool to identify hardcoded secrets in static structured text
    wifite2                                                                                              # Rewrite of the popular wireless network auditor, wifite
    win-virtio                                                                                           # Windows VirtIO Drivers
    wipe                                                                                                 # Secure file wiping utility
    wireproxy                                                                                            # Wireguard client that exposes itself as a socks5 proxy
    wireshark-qt                                                                                         #
    witness                                                                                              # A pluggable framework for software supply chain security
    wmctrl                                                                                               # CLI tool to interact with EWMH/NetWM compatible X Window Managers
    wol                                                                                                  # Implements Wake On LAN functionality in a small program
    wprecon                                                                                              # WordPress vulnerability recognition tool
    wpscan                                                                                               # Black box WordPress vulnerability scanner
    #wstunnel                                                                                             #
    #wuzz                                                                                                 # Interactive cli tool for HTTP inspection
    x2goclient                                                                                           # Graphical NoMachine NX3 remote desktop client
    xcalib                                                                                               # A tiny monitor calibration loader for X and MS-Windows
    xcape                                                                                                # Utility to configure modifier keys to act as other keys
    xdotool                                                                                              # Fake keyboard/mouse input, window management, and more
    xidel                                                                                                # Command line tool to download and extract data from HTML/XML pages as well as JSON APIs
    xorex                                                                                                # XOR Key Extractor
    xortool                                                                                              # Tool to analyze multi-byte XOR cipher
    #xpdf                                                                                                 # Viewer for Portable Document Format (PDF) files
    yara                                                                                                 # The pattern matching swiss knife for malware researchers
    yersinia                                                                                             # A framework for layer 2 attacks
    yt-dlp                                                                                               # Command-line tool to download videos from YouTube.com and other sites (youtube-dl fork)
    youtube-music                                                                                        # Electron wrapper around YouTube Music
    yq                                                                                                   # Command-line YAML/XML/TOML processor
    zap                                                                                                  # Java application for web penetration testing
    zed-editor                                                                                           # High-performance, multiplayer code editor from the creators of Atom and Tree-sitter
    zeek                                                                                                 # Network analysis framework much different from a typical IDS
    zkar                                                                                                 # Java serialization protocol analysis tool
    zmap                                                                                                 # Fast single packet network scanner designed for Internet-wide network surveys
    zotero                                                                                               # Collect, organize, cite, and share your research sources
    zzuf                                                                                                 # Transparent application input fuzzer
  ];
}
