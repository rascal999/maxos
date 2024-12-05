#!/usr/bin/env bash

echo "Pentest resources script"

usage() {
  echo "Usage: $0 [-a] [-b] [-f] [-h] [-m] [-o] [-p] [-t] [-v] [-z]" 1>&2;
  echo
  echo "-a (Auth)             Docker authentication"
  echo "-b (Submodules)       Pull submodules (all git repos)"
  #echo "-e (Educational)      Pull educational resources (git)"
  echo "-f (Force)            Force git pulls (bypass 'cache' check)"
  #echo "-g (Tools)            Pull tools (git)"
  echo "-h (Heavy)            Pull heavy images (Kali, dockerctf etc.)"
  echo "-m (Misc)             Misc things"
  echo "-o (OS)               Pull Operating Systems (docker)"
  echo "-p (PDFs)             Pull PDFs"
  echo "-t (Tools)            Pull tools (docker)"
  echo "-v (Vulnerable)       Vulnerable things (docker)"
  #echo "-w (Wordlists)        Pull wordlists (git)"
  echo "-z (ZIMs)             Pull ZIMs (kiwix)"
  echo
  echo "Examples:"
  echo "# Everything except heavy images and ZIMs"
  echo "$0 -abfmoptv"
  echo
  echo "# Everything"
  echo "$0 -abfhmoptvz"
  echo
  echo "# ISO / VM environment"
  echo "$0 -gptw"
  exit 1;
}

arg_auth=0
#arg_educational=0
arg_force=0
#arg_tools_git=0
arg_heavy=0
arg_misc=0
arg_os=0
arg_pdf=0
arg_submodules=0
arg_tools_docker=0
arg_vulnerable=0
#arg_wordlists=0
arg_zims=0

while getopts abfhmoptvz flag
do
    case "${flag}" in
        a) arg_auth=1;;
        b) arg_submodules=1;;
        #e) arg_educational=1;;
        f) arg_force=1;;
        #g) arg_tools_git=1;;
        h) arg_heavy=1;;
        m) arg_misc=1;;
        o) arg_os=1;;
        p) arg_pdf=1;;
        t) arg_tools_docker=1;;
        v) arg_vulnerable=1;;
        #w) arg_wordlists=1;;
        z) arg_zims=1;;
    esac
done

arg_sum=$((${arg_submodules} + \
           ${arg_tools_git} + \
           ${arg_heavy} + \
           ${arg_misc} + \
           ${arg_os} + \
           ${arg_pdf} + \
           ${arg_tools_docker} + \
           ${arg_vulnerable} + \
           ${arg_zims}))

# No options specified?
if [ "${arg_sum}" == "0" ]; then
    usage
fi

echo
echo "Selection"
echo "---"
echo "Docker auth: $arg_auth"
echo "Submodules: $arg_submodules"
#echo "Educational repos: $arg_educational"
echo "Force git pull: $arg_force"
#echo "Git pull: $arg_tools_git"
echo "Heavy images (docker): $arg_heavy"
echo "Misc things: $arg_misc"
echo "OS (docker): $arg_os"
echo "PDFs: $arg_pdf"
echo "Tools (docker): $arg_tools_docker"
echo "Vulnerabe things (docker): $arg_vulnerable"
#echo "Wordlists: $arg_wordlists"
echo "ZIMs: $arg_zims"
echo

function git_update() {
  DIR_ACCESSED=`find $2 -maxdepth 0 -type d -atime -1 2>/dev/null | wc -l`

  # Only pull if directory not accessed in last day
  # or forced
  if [[ "$DIR_ACCESSED" == "0" || "$arg_force" == "1" ]]; then
    git clone --depth 1 $1 $2
    cd $2
    git reset --hard
    git pull
    return 0
  fi
  return 1
}

function git_submodule_update() {
  NEXT=`pwd | grep maxos-next | wc -l`

  if [[ "$NEXT" -ne "0" ]]; then
    echo "ERROR: Not pulling submodules in maxos-next"
    return 1
  else
    git submodule init
    git submodule update
    git submodule foreach 'git fetch origin; git checkout origin/master'
    #git submodule foreach 'git stash; git pull --rebase; git rebase --skip; git pull'
  fi
}

###
### Heavy images (docker)
###
function pull_heavy_docker() {
  docker pull booyaabes/kali-linux-full
  docker pull firefart/dockerctf                           # Docker image with some common ctf tools
  docker pull tuetenk0pp/sharelatex-full                   # Overleaf image with all tlmgr packages and minted support
  docker pull six2dez/reconftw:main                        # Perform automated recon on a target domain
}

###
### Misc things
###
function pull_misc_things() {
  docker pull trufflesuite/ganache-cli                              # Local blockchain dev
  docker pull oracleinanutshell/oracle-xe-11g                       # Oracle DB
  docker pull rflathers/nginxserve                                  # nginx
  docker pull ghcr.io/linuxserver/thelounge                         # IRC client
  docker pull kizzx2/wireguard-socks-proxy                          # Expose a WireGuard tunnel as a SOCKS5 proxy
  docker pull dperson/torproxy                                      # Tor and Privoxy docker container
  docker pull zadam/trilium                                         # Personal knowledge base
  docker pull kiwix/kiwix-serve                                     # Internet. Offline.
  docker pull jgraph/drawio                                         # draw.io
  docker pull netdata/netdata                                       # Netdata dashboard
  docker pull ivre/db                                               # Network recon framework
  docker pull ivre/client                                           # Network recon framework
  docker pull ghcr.io/openbb-finance/openbbterminal-poetry:latest   # Investment Research for Everyone, Anywhere
  docker pull apache/superset                                       # Business intelligence web application
  docker pull dceoy/nginx-autoindex                                 # Nginx with autoindex
  docker pull grafana/grafana-oss                                   # Visualize metrics, logs, and traces from multiple sources
  docker pull libretranslate/libretranslate                         # Free and Open Source Machine Translation API
  docker pull lissy93/dashy                                         # A self-hostable personal dashboard built for you
  docker pull morawskim/htrace.sh                                   # Simple Swiss Army knife for http/https troubleshooting
  docker pull peterdavehello/tor-socks-proxy                        # Tiny Docker image as onion Tor SOCKS5 proxy shield
  docker pull privatebin/nginx-fpm-alpine                           # PrivateBin docker image
  docker pull ghcr.io/requarks/wiki                                 # Wiki.js | A modern and powerful wiki app built on Node.js
  docker pull searxng/searxng                                       # Free internet metasearch engine
  docker pull danielgatis/rembg                                     # Rembg is a tool to remove images background

  ### InvokeAI
  if [[ "$?" == "0" && -f "/etc/api-huggingface" ]]; then
    docker-build/build.sh
    export HUGGINGFACE_TOKEN=`cat /etc/api-hugginggface`
    docker-build/run.sh
    docker-build/run.sh
  fi

  ### jsoncrack
  if [[ "$?" == "0" ]]; then
    docker build -t jsoncrack .
  fi

  ### GraphGPT
  #cd $HOME/git/maxos/repos/misc/GraphGPT-docker
  #if [[ "$?" == "0" ]]; then
  #  docker build -t graphgpt .
  #fi

  ### v86
  cd $HOME/git/maxos/repos/misc/v86
  if [[ "$?" == "0" ]]; then
    docker build -f tools/docker/exec/Dockerfile -t v86:alpine-3.14 .
  fi
}

###
### Operating Systems
###
function pull_os_docker() {
  docker pull alpine
  docker pull ubuntu
  docker pull centos
  docker pull debian
  docker pull amazonlinux
  docker pull fedora
  #docker pull kalilinux/kali-rolling
}

###
### Vulnerable things
###
function pull_vulnerable_things_docker() {
  docker pull pygoat/pygoat                                # Intentionally vuln web app
  docker pull psiinon/bodgeit                              # The BodgeIt Store
  docker pull appsecco/dvna:sqlite                         # Damn Vulnerable NodeJS Application
  docker pull dolevf/dvga                                  # Damn Vulnerable GraphQL Application
  docker pull citizenstig/dvwa                             # Damn Vulnerable Web Application (DVWA)
  docker pull l505/vulnerablewordpress                     # Vulnerable WordPress Installation
  docker pull hmlio/vaas-cve-2014-6271                     # Vulnerability as a service: Shellshock
  docker pull hmlio/vaas-cve-2014-0160                     # Vulnerability as a service: Heartbleed
  docker pull opendns/security-ninjas                      # Security Ninjas
  docker pull ismisepaul/securityshepherd                  # OWASP Security Shepherd
  docker pull danmx/docker-owasp-webgoat                   # OWASP WebGoat Project docker image
  #docker pull vulnerables/web-owasp-nodegoat               # OWASP NodeGoat
  docker pull citizenstig/nowasp                           # OWASP Mutillidae II Web Pen-Test Practice Application
  docker pull bkimminich/juice-shop                        # OWASP Juice Shop
  docker pull eystsen/altoro                               # Altoro Mutual - Demo Vulnerable Web Bank
  docker pull mutzel/all-in-one-hackazon:postinstall       # LAMP Hackazon deployment in a single container
  docker pull tuxotron/tiredful-api                        # Broken web application based on REST API
  docker pull tuxotron/xvwa                                # Xtreme Vulnerable Web Application
  docker pull vulnerables/web-owasp-nodegoat               # OWASP NodeGoat, a vulnerable nodejs application
}

###
### Tools (docker)
###
function pull_tools_docker() {
  docker pull owasp/zap2docker-stable                      # official OWASP ZAP
  docker pull wpscanteam/wpscan                            # official WPScan
  docker pull metasploitframework/metasploit-framework     # Official Metasploit
  docker pull diogomonica/docker-bench-security            # Docker Bench for Security
  docker pull phocean/msf                                  # Docker Metasploit
  docker pull frapsoft/slowhttptest                        # Application Layer DoS attack simulator
  docker pull guidelacour/whatweb                          # Next generation web scanner
  docker pull opensecurity/cmsscan                         # CMS Scanner: Scan Wordpress, Drupal, Joomla, vBulletin
  docker pull epi052/feroxbuster                           # A fast, simple, recursive content discovery tool written in Rust
  #docker pull greenbone/openvas                            # OpenVAS is a full-featured vulnerability scanner
  docker pull mpepping/cyberchef                           # The Cyber Swiss Army Knife
  docker pull phocean/beef                                 # BeEF framework for XSS browser exploitation
  docker pull byt3bl33d3r/crackmapexec                     # A swiss army knife for pentesting networks
  docker pull rossja/ncc-scoutsuite                        # Multi-Cloud Security Auditing Tool
  docker pull dstotijn/hetty                               # Hetty is an HTTP toolkit for security research
  docker pull stefanscherer/winrm                          # The ultimate WinRM shell for hacking/pentesting
  docker pull filebrowser/filebrowser                      # Web File Browser
  docker pull remnux/ciphey                                # Automatically decrypt, decode, and crack
  docker pull bettercap/bettercap                          # The Swiss Army knife for 802.11, BLE, IPv4 and IPv6 networks
  docker pull dominicbreuker/stego-toolkit                 # Collection of steganography tools - helps with CTF challenges
  docker pull mythril/myth                                 # Security analysis tool for EVM bytecode
  docker pull trailofbits/manticore                        # Symbolic execution tool for smart contracts
  docker pull trailofbits/eth-security-toolbox             # Trail of Bits Ethereum security tools
  docker pull williamjackson/cartography                   # Consolidates infrastructure assets and the relationships between them
  docker pull mlabouardy/komiser                           # Cloud Environment Inspector
  docker pull toniblyx/prowler                             # Perform AWS security audits
  docker pull arkadiyt/aws_public_ips                      # Fetch all public IP addresses tied to your AWS account
  docker pull accurics/terrascan                           # Detect compliance and security violations across IaC
  docker pull bridgecrew/checkov                           # Checkov is a static code analysis tool for infrastructure-as-code
  docker pull projectdiscovery/nuclei                      # Configurable targeted scanning based on templates
  docker pull cmnatic/rustscan                             # The Modern Port Scanner
  docker pull vuls/vuls                                    # Vulnerability scanner for Linux/FreeBSD
  docker pull xer0dayz/sn1per                              # Discover the attack surface and prioritize risks
  docker pull opensecurity/mobile-security-framework-mobsf # Mobile Security Framework (MobSF)
  #docker pull dwisiswant0/apkleaks                        # Scanning APK file for URIs, endpoints & secrets
  docker pull alekzonder/puppeteer                         # Headless Chrome Node.js API
  docker pull simonthomas/theharvester                     # E-mails, subdomains and names Harvester - OSINT
  docker pull unapibageek/ctfr                             # Abusing Certificate Transparency logs for domains
  docker pull machines/filestash                           # A modern web client for file protocols
  docker pull theyahya/sherlock                            # Hunt down social media accounts
  docker pull lirantal/is-website-vulnerable               # Find known security vulnerabilities in frontend JS libs
  docker pull guidelacour/dnsenum                          # Enumerates DNS information from a domain among other things
  docker pull elceef/dnstwist                              # Domain name permutation engine
  docker pull thewhiteh4t/finalrecon                       # The Last Web Recon Tool You'll Need
  docker pull screetsec/sudomy:v1.1.9-dev                  # Subdomain enumeration tool
  docker pull xshuden/xsstrike                             # Most advanced XSS scanner
  docker pull djangobyjeffrey/gtfobins                     # Bypass local security restrictions in misconfigured systems
  docker pull madduci/docker-compiler-explorer             # Run compilers from your web browser and interact with the assembly
  docker pull aquasec/trivy                                # Vulnerability scanner for container images, file systems etc.
  docker pull arachni/arachni                              # Web Application Security Scanner Framework
  docker pull carlospolop/legion                           # Automatic Enumeration Tool based in Open Source tools
  docker pull ghcr.io/mxrch/ghunt                          # Offensive Google framework
  docker pull rascal999/houdini                            # Docker Images for Network Intrusion
  docker pull sundowndev/phoneinfoga                       # Information gathering & OSINT framework for phone numbers
  docker pull vainlystrain/tidos-framework                 # Offensive Manual Web Application Penetration Testing Framework
  docker pull verovaleros/domain_analyzer                  # Analyze the security of domain by finding information
  docker pull rflathers/webdav                             # Share current directory over anonymous webdav
  docker pull rflathers/impacket                           # Collection of Python classes for working with network protocols

  ### https://github.com/cybersecsi/RAUDI
  docker pull secsi/apktool
  docker pull secsi/bfac
  docker pull secsi/cloudfail
  docker pull secsi/cmseek
  docker pull secsi/dirb
  docker pull secsi/dirhunt
  docker pull secsi/dirsearch
  docker pull secsi/dnscan
  docker pull secsi/dvcs-ripper
  docker pull secsi/ffuf
  docker pull secsi/fierce
  docker pull secsi/findsploit
  docker pull secsi/getjs
  docker pull secsi/gitrob
  docker pull secsi/gittools
  docker pull secsi/gobuster
  docker pull secsi/gospider
  docker pull secsi/httprobe
  docker pull secsi/hydra
  docker pull secsi/jwt_tool
  docker pull secsi/knockpy
  docker pull secsi/lfisuite
  docker pull secsi/masscan
  docker pull secsi/massdns
  docker pull secsi/nmap
  docker pull secsi/puredns
  docker pull secsi/race-the-web
  docker pull secsi/restfulharvest
  docker pull secsi/retire
  docker pull secsi/sandcastle
  docker pull secsi/sqlmap
  docker pull secsi/sublist3r
  docker pull secsi/theharvester
  docker pull secsi/waybackpy
  docker pull secsi/whatweb
  #docker pull secsi/eyewitness
  docker pull secsi/nikto
}

###
### PDFs
###
function pull_pdfs() {
  ### AWS
  mkdir -p $HOME/pdfs/education/aws
  wget -c https://d1.awsstatic.com/whitepapers/aws-overview.pdf \
    -O $HOME/pdfs/education/aws/aws-overview.pdf
  wget -c https://docs.aws.amazon.com/whitepapers/latest/introduction-aws-security/introduction-aws-security.pdf \
    -O $HOME/pdfs/education/aws/introduction-aws-security.pdf
  wget -c https://docs.aws.amazon.com/wellarchitected/latest/security-pillar/wellarchitected-security-pillar.pdf \
    -O $HOME/pdfs/education/aws/wellarchitected-security-pillar.pdf
  wget -c https://d1.awsstatic.com/whitepapers/compliance/Intro_to_Security_by_Design.pdf \
    -O $HOME/pdfs/education/aws/Intro_to_Security_by_Design.pdf
  wget -c https://d1.awsstatic.com/whitepapers/architecture/AWS_Well-Architected_Framework.pdf \
    -O $HOME/pdfs/education/aws/AWS_Well-Architected_Framework.pdf
  wget -c https://d0.awsstatic.com/whitepapers/compliance/AWS_Risk_and_Compliance_Whitepaper.pdf \
    -O $HOME/pdfs/education/aws/AWS_Risk_and_Compliance_Whitepaper.pdf
  wget -c https://d1.awsstatic.com/whitepapers/Security/AWS_Security_Checklist.pdf \
    -O $HOME/pdfs/education/aws/AWS_Security_Checklist.pdf
  wget -c https://d0.awsstatic.com/whitepapers/compliance/AWS_HIPAA_Compliance_Whitepaper.pdf \
    -O $HOME/pdfs/education/aws/AWS_HIPAA_Compliance_Whitepaper.pdf
  wget -c https://d1.awsstatic.com/whitepapers/aws_cloud_adoption_framework.pdf \
    -O $HOME/pdfs/education/aws/aws_cloud_adoption_framework.pdf
  wget -c https://d1.awsstatic.com/whitepapers/compliance/AWS_Auditing_Security_Checklist.pdf \
    -O $HOME/pdfs/education/aws/AWS_Auditing_Security_Checklist.pdf
  wget -c https://d1.awsstatic.com/whitepapers/compliance/AWS_CIS_Foundations_Benchmark.pdf \
    -O $HOME/pdfs/education/aws/AWS_CIS_Foundations_Benchmark.pdf
  wget -c https://d1.awsstatic.com/whitepapers/aws_security_incident_response.pdf \
    -O $HOME/pdfs/education/aws/aws_security_incident_response.pdf
  wget -c https://d1.awsstatic.com/whitepapers/Overview-AWS-Lambda-Security.pdf \
    -O $HOME/pdfs/education/aws/Overview-AWS-Lambda-Security.pdf
  wget -c https://d1.awsstatic.com/whitepapers/aws-kms-best-practices.pdf \
    -O $HOME/pdfs/education/aws/aws-kms-best-practices.pdf
  wget -c https://d1.awsstatic.com/whitepapers/Security/amazon-efs-encrypted-filesystems.pdf \
    -O $HOME/pdfs/education/aws/amazon-efs-encrypted-filesystems.pdf
  wget -c https://d1.awsstatic.com/whitepapers/Security/security-of-aws-cloudhsm-backups.pdf \
    -O $HOME/pdfs/education/aws/security-of-aws-cloudhsm-backups.pdf
  wget -c https://docs.aws.amazon.com/whitepapers/latest/security-overview-aws-lambda/security-overview-aws-lambda.pdf \
    -O $HOME/pdfs/education/aws/security-overview-aws-lambda.pdf
  wget -c https://d0.awsstatic.com/whitepapers/compliance/NIST_Cybersecurity_Framework_CSF.pdf \
    -O $HOME/pdfs/education/aws/NIST_Cybersecurity_Framework_CSF.pdf
  wget -c https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-144.pdf \
    -O $HOME/pdfs/education/aws/nistspecialpublication800-144.pdf
  wget -c https://d1.awsstatic.com/whitepapers/Security/security-at-the-edge.pdf \
    -O $HOME/pdfs/education/aws/security-at-the-edge.pdf
  wget -c https://d0.awsstatic.com/whitepapers/aws-kms-best-practices.pdf \
    -O $HOME/pdfs/education/aws/aws-kms-best-practices.pdf

  ### Misc
  wget -c https://alm.gg/drive-download-20221005T135825Z-001.zip \
    -O $HOME/pdfs/education/alm_gg_pdfs.zip
  unzip -o $HOME/pdfs/education/alm_gg_pdfs.zip -d $HOME/git/maxos/repos/education/pdfs/misc
  wget -c https://alm.gg/Yeahhub_ebooks.zip \
    -O $HOME/pdfs/education/Yeahhub_ebooks.zip
  unzip -o $HOME/pdfs/education/Yeahhub_ebooks.zip -d $HOME/git/maxos/repos/education/pdfs/yeahhub
}

###
### Educational repos (GitHub)
###
function pull_educational_repos() {
  rm -rf $HOME/git/maxos/repos/pentest-education/CheatSheetSeriesZip
  mkdir $HOME/git/maxos/repos/pentest-education/CheatSheetSeriesZip
  wget https://cheatsheetseries.owasp.org/bundle.zip -O $HOME/git/maxos/repos/pentest-education/CheatSheetSeriesZip/bundle.zip
  unzip $HOME/git/maxos/repos/pentest-education/CheatSheetSeriesZip/bundle.zip -d $HOME/git/maxos/repos/pentest-education/CheatSheetSeriesZip
}

###
### Pentest Tools
###
function pull_tool_repos() {
  ### Pentest Frameworks
  cd $HOME/git/maxos/repos/pentest-frameworks/owasp-mstg
  bash tools/docker/pandoc_makedocs.sh

  #git_update --depth 1 https://github.com/andresriancho/w3af.git $HOME/git/pentest-tools/w3af

  ### Tools which need building
  # AutoRecon
  cd $HOME/git/maxos/repos/pentest-tools/AutoRecon-docker
  if [[ "$?" == "0" ]]; then
    docker build -t autorecon .
  fi

  # IntelOwl
  cd $HOME/git/maxos/repos/pentest-tools/IntelOwl/docker
  cp env_file_app_template env_file_app
  cp env_file_postgres_template env_file_postgres
  cp env_file_integrations_template env_file_integrations
  cd ..
  python -m venv .venv
  source .venv/bin/activate
  bash ./initialize.sh
  python3 start.py prod up -d
  echo "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser('admin', 'admin@myproject.com', 'password')" | docker exec -i intelowl_uwsgi python3 manage.py shell
  deactivate

  # OpenVAS
  #git clone https://github.com/greenbone/openvas-scanner.git

  # ATT&CK Navigator
  cd $HOME/git/maxos/repos/pentest-tools/attack-navigator
  if [[ "$?" == "0" ]]; then
    sed 's/node:16/node:14/g' Dockerfile
    docker build -t attack-navigator .
  fi

  # Osintgram
  cd $HOME/git/maxos/repos/pentest-tools/Osintgram
  if [[ "$?" == "0" ]]; then
    docker build -t osintgram .
  fi

  # social-analyzer
  cd $HOME/git/maxos/repos/pentest-tools/social-analyzer
  if [[ "$?" == "0" ]]; then
    docker build -t social-analyzer .
  fi

  # OpenCVE
  cd $HOME/git/maxos/repos/exploits/opencve-docker
  if [[ "$?" == "0" ]]; then
    cp $HOME/git/maxos/config/opencve/opencve.cfg conf
    cp $HOME/git/maxos/config/opencve/docker-compose.yml .

    # Build and spin up
    docker-compose build
    docker-compose up -d postgres-opencve redis-opencve webserver celery_worker
    docker exec -it webserver opencve upgrade-db
    docker exec -it webserver opencve import-data --confirm
  fi

  # redgo
  cd $HOME/git/maxos/repos/pentest-tools/redgo
  if [[ "$?" == "0" ]]; then
    docker build . -t redgo
  fi

  # twa
  cd $HOME/git/maxos/repos/pentest-tools/twa
  if [[ "$?" == "0" ]]; then
    docker build . -t twa
  fi

  # howmanypeoplearearound
  cd $HOME/git/maxos/repos/pentest-tools/howmanypeoplearearound
  if [[ "$?" == "0" ]]; then
    docker build . -t howmanypeoplearearound
  fi

  # shcheck
  cd $HOME/git/maxos/repos/pentest-tools/shcheck
  if [[ "$?" == "0" ]]; then
    docker build . -t shcheck
  fi

  # DrHeader
  cd $HOME/git/maxos/repos/pentest-tools/DrHeader
  if [[ "$?" == "0" ]]; then
    docker build . -t drheader
  fi

  # Nettacker
  cd $HOME/git/maxos/repos/pentest-tools/Nettacker
  if [[ "$?" == "0" ]]; then
    docker build . -t nettacker
  fi

  # Raccoon
  cd $HOME/git/maxos/repos/pentest-tools/Raccoon
  if [[ "$?" == "0" ]]; then
    docker build -t evyatarmeged/raccoon .
  fi

  # rengine
  cd $HOME/git/maxos/repos/pentest-tools/rengine
  if [[ "$?" == "0" ]]; then
    make certs
    make build
  fi

  # Infoga
  cd $HOME/git/maxos/repos/pentest-tools/Infoga
  if [[ "$?" == "0" ]]; then
    docker build . -t infoga
  fi

  # apkleaks
  cd $HOME/git/maxos/repos/pentest-tools/apkleaks
  if [[ "$?" == "0" ]]; then
    docker build . -t apkleaks
  fi

  # angularjs-csti-scanner
  cd $HOME/git/maxos/repos/pentest-tools/angularjs-csti-scanner.git
  if [[ "$?" == "0" ]]; then
    docker build . -t angularjs-csti-scanner
  fi

  # Arjun
  cd $HOME/git/maxos/repos/pentest-tools/Arjun
  if [[ "$?" == "0" ]]; then
    docker build . -t arjun
  fi

  # frida
  mkdir -p $HOME/venv/pentest-tools/frida
  python -m venv $HOME/venv/pentest-tools/frida
  source $HOME/venv/pentest-tools/frida/bin/activate
  pip install frida
  pip install frida-tools

  # cloudsploit
  cd $HOME/git/maxos/repos/pentest-tools/cloudsploit
  if [[ "$?" == "0" ]]; then
    docker build . -t cloudsploit:0.0.1
  fi

  # S3Scanner
  cd $HOME/git/maxos/repos/pentest-tools/S3Scanner
  if [[ "$?" == "0" ]]; then
    docker build . -t s3scanner:latest
  fi

  # aws-security-viz
  cd $HOME/git/maxos/repos/pentest-tools/aws-security-viz
  if [[ "$?" == "0" ]]; then
    docker build -t sec-viz .
  fi

  # CloudMapper
  cd $HOME/git/maxos/repos/pentest-tools/cloudmapper
  if [[ "$?" == "0" ]]; then
    docker build -t cloudmapper .
  fi

  # EyeWitness
  cd $HOME/git/maxos/repos/pentest-tools/EyeWitness
  if [[ "$?" == "0" ]]; then
    docker build --build-arg user=$USER --tag eyewitness --file ./Python/Dockerfile .
  fi

  # spiderfoot
  cd $HOME/git/maxos/repos/pentest-tools/spiderfoot
  if [[ "$?" == "0" ]]; then
    docker build . -t spiderfoot
  fi

  # routersploit
  git_update https://www.github.com/threat9/routersploit $HOME/git/maxos/repos/pentest-tools/routersploit
  if [[ "$?" == "0" ]]; then
    docker build -t routersploit .
  fi

  # scanless
  cd $HOME/git/maxos/repos/pentest-tools/scanless
  if [[ "$?" == "0" ]]; then
    docker build -t scanless .
  fi

  # joomscan
  cd $HOME/git/maxos/repos/pentest-tools/joomscan
  if [[ "$?" == "0" ]]; then
    docker build -t rezasp/joomscan .
  fi

  # MHDDoS
  cd $HOME/git/maxos/repos/pentest-tools/MHDDoS
  if [[ "$?" == "0" ]]; then
    docker build . -t mhddos
  fi

  # impacket
  cd $HOME/git/maxos/repos/pentest-tools/impacket
  if [[ "$?" == "0" ]]; then
    docker build -t "impacket:latest" .
  fi

  # droopescan
  cd $HOME/git/maxos/repos/pentest-tools/droopescan
  if [[ "$?" == "0" ]]; then
    docker build -t droope/droopescan .
  fi

  # vulnx
  cd $HOME/git/maxos/repos/pentest-tools/VulnX
  if [[ "$?" == "0" ]]; then
    docker build -t vulnx ./docker/
  fi
}

###
### Wordlists
###
function pull_wordlists() {
  # $HOME/wordlists
  mkdir $HOME/wordlists
  wget https://gist.github.com/jhaddix/b80ea67d85c13206125806f0828f4d10/raw/c81a34fe84731430741e0463eb6076129c20c4c0/content_discovery_all.txt -O $HOME/wordlists/content_discovery_all.txt
  wget -c https://alm.gg/onelistforall_all.txt -O $HOME/wordlists/onelistforall_all.txt
  wget -c https://raw.githubusercontent.com/dwyl/english-words/master/words.txt -O $HOME/wordlists/english_words.txt
}

###
### ZIMs
###
function pull_zims() {
  sudo aria2c -x 2 --continue=true -d /home/user/.local/share/kiwix https://download.kiwix.org/zim/wikipedia/wikipedia_en_all_nopic_2022-01.zim
  sudo aria2c -x 2 --continue=true -d /home/user/.local/share/kiwix https://download.kiwix.org/zim/gutenberg/gutenberg_en_all_2022-05.zim
  sudo aria2c -x 2 --continue=true -d /home/user/.local/share/kiwix https://download.kiwix.org/zim/zimit/cheatography.com_en_all_2021-09.zim
}

# hetty fs
mkdir $HOME/.hetty

# Docker auth
if [ $arg_auth == 1 ]; then
  docker login
fi

# Submodules
if [ $arg_submodules == 1 ]; then
  git_submodule_update
fi

# Misc tools
if [ $arg_misc == 1 ]; then
  pull_misc_things
fi

# PDFs
if [ $arg_pdf == 1 ]; then
  pull_pdfs
fi

# OS (docker)
if [ $arg_os == 1 ]; then
  pull_os_docker
fi

# Tools (docker)
if [ $arg_tools_docker == 1 ]; then
  pull_tools_docker
fi

# Vulnerable things (docker)
if [ $arg_vulnerable == 1 ]; then
  pull_vulnerable_things_docker
fi

# Heavy images (docker)
if [ $arg_heavy == 1 ]; then
  pull_heavy_docker
fi

# ZIMs
if [ $arg_zims == 1 ]; then
  pull_zims
fi

# Notify
/home/user/git/maxos/scripts/telegram_notify.sh -a -m "Finished updating resources"
