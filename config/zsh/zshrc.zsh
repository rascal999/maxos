# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#[[ -s "$HOME/.grc.zsh" ]] && source $HOME/.grc.zsh

[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"

# Variables
PORT_JUPYTER=8000
PORT_IVRE=8010
PORT_RENGINE=8020
PORT_OPENVAS=8030
PORT_CYBERCHEF=8040
PORT_MOBSF=8050
PORT_SPIDERFOOT=8060
PORT_AWS_SECURITY_VIZ=8070
PORT_BURP=8080
PORT_SHARELATEX=8090
PORT_GOTTY=9000
PORT_FOCALBOARD=9010
PORT_TRILIUM=9020
PORT_WIREGUARD_ADMIN=9030
PORT_FILESTASH_SCREENSHOTS=9040
PORT_FILESTASH_TMP_DIRECTORY=9041
PORT_HOUDINI=9050
PORT_KIWIX=9060
PORT_LIBRETRANSLATE=9070
PORT_SEARXNG=9080
PORT_DASHY=9090
PORT_GTFOBINS=10000
PORT_NGINX_ISO=10010
PORT_COMPILER_EXPLORER=10020
PORT_OPENCVE=10030
PORT_PRIVATEBIN=10040
PORT_HOME_ASSISTANT=10050
PORT_GRAFANA=10060
PORT_NGINX=10070
PORT_JSONCRACK=10090
PORT_NESSUS=10100
PORT_GIFCAP=10110
PORT_ATTACK_NAVIGATOR=10120
PORT_REMBG=10130
PORT_PIHOLE=10140
PORT_WEBTOP=10150
PORT_GRAPHGPT=10160
PORT_MEMOS=10170
PORT_MERMAID=10180
PORT_LIBREDDIT=10190
PORT_WIREGUARD=51820
PORT_EXCALIDRAW=10200
PORT_MINISERVE=10210
PORT_OLLAMA=10220
PORT_WEB_CHECK=10230
PORT_PLANKA=10240
PORT_WIREPROXY_SOCKS=10250
PORT_WIREPROXY_HTTP=10260

export MCFLY_KEY_SCHEME=vim
export MCFLY_RESULTS=40
export MCFLY_RESULTS_SORT=LAST_RUN

if [ -n "${DISPLAY+x}" ]; then
  xmodmap -e "keycode 81=Prior KP_9"
  xmodmap -e "keycode 89=Next KP_3"
fi

bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

###
### sshm
###
sshm() {
  TARGET_HOST=`echo $@ | choose -f '@' 1 | choose 0`
  if [[ "$@" == *"@"* ]]; then
    TARGET_USER=`echo $@ | choose -f '@' 0 | choose -1`
  else
    TARGET_USER="$USER"
  fi

  TARGET_DIR="/home/user/tmp_today/${TARGET_HOST}_mount"
  mkdir -p $TARGET_DIR

  sshfs -o uid=`id -u user` -o gid=`id -g user` ${TARGET_USER}@${TARGET_HOST}:/ $TARGET_DIR
  ssh $@
  umount $TARGET_DIR
}

###
### SSH alert
###
if [[ -n "$SSH_CONNECTION" ]]; then
  screen -adm $HOME/git/maxos/scripts/telegram_notify.sh -a -q -m "Login from $SSH_CLIENT"
fi

###
### Dunst
###
dunst-handle() {
  if [[ "$#" -eq "2" ]]; then
    ACTION=$(dunstify --action="default,Open" "$1")
    case "$ACTION" in
    "default")
      firefox "$2"
      ;;
    esac
  else
    dunstify "$1"
  fi
}

###
### Misc
###
a.notify()
{
  /home/user/git/maxos/scripts/telegram_notify.sh "$@"
}

new() {
  echo "### New commands ###"
  echo "a.alarm                     a.alarm 10:30 \"Meeting\""
  echo "a.bust                      Crawler and gobuster with sensible wordlists"
  echo "a.cp                        Chromium proxy instance (HTTP 8080)"
  echo "d.carb                      Terminal web browser (carbonyl)"
  echo "a.eb                        Extract Firefox bookmarks"
  echo "a.ech                       Export command history"
  echo "a.localhostrun-gotty        Terminal command over web"
  echo "a.localhostrun-privatebin   Privatebin over web"
  echo "a.iam                       Enumerate perms for AWS keys (enumerate-iam)"
  echo "a.ips                       Return all IPs in CIDR range in given file"
  echo "a.netscan                   Network scanning (nmap/masscan)"
  echo "a.netscanparse              Format netscan results for Logseq"
  echo "a.sqli                      Find SQLi issues against target"
  echo "a.xss                       Find XSS issues against target"
  echo "arsenal                     Generate commands for security and network tools"
  echo "bwcalc                      Bandwidth transfer time estimator"
  echo "d.autorecon                 Parallel network scans (good for CTF)"
  echo "d.cloudfox                  Cloud scanner"
  echo "d.dos                       MHDDoS"
  echo "d.katana                    Web crawler"
  echo "d.msprobe                   Find M$ things for password spraying and enum"
  echo "d.orbitaldump               OrbitalDump - SSH brute forcer"
  echo "d.phash                     psudohash"
  echo "d.rg                        redgo"
  echo "d.sshere                    SecretScanner for container scanning"
  echo "d.tho                       Trufflehog against org"
  echo "d.thr                       Trufflehog against repo"
  echo "d.webtop                    Ubuntu, Alpine, Arch, and Fedora based Webtop images"
  echo "now                         date +\"%Y%m%d_%H%M%S\""
  echo "sshm                        SSH and mount target / directory using sshfs"
}

test-vpn() {
  ${HOME}/git/maxos/scripts/wg_test.sh
}

now() {
  date +"%Y%m%d_%H%M%S"
}

a.cl() {
  echo "Get content length of URL"
  echo
  if [[ "$#" -ne "1" ]]; then
    echo "ERROR: Specify:"
    echo "- target site"
    echo
    echo "$0 http://testphp.vulnweb.com/"
    return 1
  fi

  UUID=`uuidgen`
  echo "Should be 404 content length"
  echo "curl -sI $1/XXXX${UUID} | grep -i Content-Length | choose 1"
  echo
  curl -sI $1/XXX${UUID} | grep -i Content-Length | choose 1
  echo

  UUID=`uuidgen`
  echo "curl -sI $1/XX${UUID} | grep -i Content-Length | choose 1"
  echo
  curl -sI $1/XXX${UUID} | grep -i Content-Length | choose 1
  echo

  echo "Should be 200 content length"
  echo "curl -sI $1 | grep -i Content-Length | choose 1"
  echo
  curl -sI $1 | grep -i Content-Length | choose 1
  echo
}

a.cp() {
  chromium --force-device-scale-factor=1.6 --proxy-server='127.0.0.1:8080' $@
}

a.bust() {
  echo "Crawler/buster helper"
  echo
  if [[ "$#" -ne "4" ]]; then
    echo "ERROR: Specify:"
    echo "- target site"
    echo "- extension(s)"
    echo "- excluded HTTP codes"
    echo "- excluded response lengths"
    echo
    echo "$0 http://testphp.vulnweb.com/ html,php 400,401,403,404 1620"
    return 1
  fi

  TARGET=`echo $1 | choose -f '//' 1`
  NOW=`date "+%Y%m%d_%H%M%S"`
  ASSESSMENT_NAME=${NOW}_${TARGET}

  mkdir $HOME/scans/$ASSESSMENT_NAME
  echo file://$HOME/scans/$ASSESSMENT_NAME
  echo

  # httpx
  echo "### httpx"
  echo $1 | httpx -silent -status-code -content-length -content-type -jarm -rt -title -tech-detect -ip -web-server -probe -websocket -cname -vhost -http2 -json -tls-grab -pipeline -cdn -hash sha256 | jq > $HOME/scans/$ASSESSMENT_NAME/httpx.txt
  cat $HOME/scans/$ASSESSMENT_NAME/httpx.txt

  # katana crawler
  docker run --rm redgo katana -u $1 > $HOME/scans/$ASSESSMENT_NAME/katana.txt
  echo "### katana output"
  cat $HOME/scans/$ASSESSMENT_NAME/katana.txt

  # English words with elected extensions
  echo "### gobuster (english)"
  gobuster dir --url $1 --wordlist /home/user/wordlists/english_words.txt -b $3 --no-error -x $2 --exclude-length $4 -o $HOME/scans/$ASSESSMENT_NAME/gobuster_english.txt -k

  # onelistforallshort
  echo "### gobuster (onelistforallshort)"
  gobuster dir --url $1 --wordlist /home/user/git/maxos/repos/wordlists/OneListForAll/onelistforallshort.txt -b $3 --no-error --exclude-length $4 -o $HOME/scans/$ASSESSMENT_NAME/gobuster_onelistforallshort.txt -k

  echo "Running onelistforall_all.txt via screen.."
  # onelistforall_all
  echo "### gobuster (onelistforall_all)"
  gobuster dir --url $1 --wordlist /home/user/git/maxos/repos/wordlists/OneListForAll/onelistforall_all.txt -b $3 --no-error --exclude-length $4 -o $HOME/scans/$ASSESSMENT_NAME/gobuster_onelistforall_all.txt -k
}

a.sqli() {
  if [[ "$#" -lt "1" ]]; then
    echo "ERROR: Specify target site"
    echo "$0 http://testphp.vulnweb.com/"
    return 1
  fi

  TMP_FILE=`uuidgen | choose -f '-' -1`

  echo $1 |\
  hakrawler > /tmp/sqli_${TMP_FILE} && \
  cat /tmp/sqli_${TMP_FILE} |\
  echo $1 | docker run -i --rm redgo waybackurls --no-subs |\
  grep -o "http[^ ]*" > /tmp/sqli_filter_urls_${TMP_FILE}.txt && \
  cat /tmp/sqli_filter_urls_${TMP_FILE}.txt |\
  grep = > /tmp/sqli_parameter_urls_${TMP_FILE}.txt && \
  cat /tmp/sqli_parameter_urls_${TMP_FILE}.txt | grep "$1" | sort | uniq |\
  sqlmap -v 0 -m -

  screen -adm $HOME/git/maxos/scripts/telegram_notify.sh -a -q -m "SQLi scan finished for $1"
}

a.iam() {
  if [[ "$#" -lt "2" ]]; then
    echo "ERROR: Specify AWS key and secret"
    echo "$0 <aws-key> <aws-secret>"
    return 1
  fi

  docker run --rm redgo python3 enumerate-iam/enumerate-iam.py --access-key $1 --secret-key $2
}

a.gsa() {
  git submodule add --force $@
}

a.xss() {
  if [[ "$#" -lt "1" ]]; then
    echo "ERROR: Specify target site"
    echo "$0 http://testphp.vulnweb.com/"
    return 1
  fi

  TMP_FILE=`uuidgen | choose -f '-' -1`

  echo $1 |\
  hakrawler > /tmp/xss_${TMP_FILE} && \
  cat /tmp/xss_${TMP_FILE} && \
  echo $1 | docker run -i --rm redgo waybackurls --no-subs |\
  grep -o "http[^ ]*" > /tmp/xss_filter_urls_${TMP_FILE}.txt && \
  cat /tmp/xss_filter_urls_${TMP_FILE}.txt |\
  grep = > /tmp/xss_parameter_urls_${TMP_FILE}.txt && \
  cat /tmp/xss_parameter_urls_${TMP_FILE}.txt | grep "$1" | sort | uniq |\
  docker run -iv `pwd`:/mnt --rm redgo dalfox --no-spinner -S -b tigv2.xss.ht pipe

  screen -adm $HOME/git/maxos/scripts/telegram_notify.sh -a -q -m "XSS scan finished for $1"
}

a.eb() {
  if [[ "$#" -lt "1" ]]; then
    echo "ERROR: Must specify bookmarks folder"
    echo "$0 Recon"
    return 1
  fi

  cat $HOME/git/maxos/config/firefox/firefox-policies.json | jq ".[].ManagedBookmarks[] | select(.name==\"$1\") | .children[].url" | sed 's/"//g' | grep -v "null"
}

a.r() {
  export TIMESTAMP = `date +%Y%m%d_%H%M%S` && asciinema rec $HOME/asciinema/asciinema_$TIMESTAMP.log;
}

a.k() {
  grc kubectl $@
}

a.d() {
  grc docker $@
}

a.kga() {
  grc kubectl get all
}

a.dpa() {
  grc docker ps -a
}

a.drr() {
  docker run -it --rm $@
}

a.nixi() {
  nix-store -q --references /var/run/current-system/sw | cut -d'-' -f2-
}

a.pingg() {
  grc ping 8.8.8.8 -c 1
}

a.pip() {
  curl https://ifconfig.me
}

a.sitecopy() {
  wget -k -K -E -r -l 10 -p -N -F -nH $@
}

a.st() {
  wget http://ipv4.download.thinkbroadband.com/1GB.zip -O /dev/null
}

a.ytmp3() {
  youtube-dl --extract-audio --audio-format mp3 $@
}

a.netscan() {
  /home/user/git/maxos/scripts/netscan.sh $@
}

a.ips() {
  /home/user/git/maxos/scripts/ips_from_file.py --input $@
}

a.netscanparse() {
  /home/user/git/maxos/scripts/netscan_logseq.py $@
}

a.agenix() {
  sudo EDITOR=vim nix --extra-experimental-features flakes --extra-experimental-features nix-command run github:ryantm/agenix -- -i /etc/ssh/ssh_host_ed25519_key $@
}

# export command history
a.ech() {
  sqlite3 $HOME/.local/share/mcfly/history.db "select cmd from commands" | sort | uniq
}

a.fo() {
  firefox `pwd`
}

a.gg() {
  googler --np "$@"
}

a.vpn() {
  /home/user/git/maxos/scripts/vpn.sh "$@"
}

bwcalc() {
  /home/user/git/maxos-next/scripts/bwcalc.py "$@"
}

d.tho() {
  if [[ "$#" -ne "1" ]]; then
    echo "ERROR: Must specify org to scan:"
    echo "$0 microsoft"
    return 1
  fi

  if [[ -f "/etc/token-github" ]]; then
    docker run -t --rm -v "$PWD:/pwd" trufflesecurity/trufflehog:latest github --org=$1 --token=`cat /etc/token-github`
  else
    docker run -t --rm -v "$PWD:/pwd" trufflesecurity/trufflehog:latest github --org=$1
  fi
}

d.thr() {
  if [[ "$#" -ne "1" ]]; then
    echo "ERROR: Must specify repo to scan:"
    echo "$0 https://github.com/rascal999/maxos"
    return 1
  fi

  if [[ -f "/etc/token-github" ]]; then
    docker run -t --rm -v "$PWD:/pwd" trufflesecurity/trufflehog:latest github --repo=$1 --token=`cat /etc/token-github`
  else
    docker run -t --rm -v "$PWD:/pwd" trufflesecurity/trufflehog:latest github --repo=$1
  fi
}

d.carb() {
  URL=https://reddit.com

  if [[ "$#" -eq "1" ]]; then
    URL=$1
  fi

  docker run --rm -ti fathyb/carbonyl $URL
}

d.katana() {
  if [[ "$#" -lt "2" ]]; then
    echo "ERROR: Must specify at least something like:"
    echo "$0 -u https://target.com"
    return 1
  fi
  NOW=`date "+%Y%m%d_%H%M%S"`
  mkdir -p $HOME/scans/katana/$NOW

  echo "Args: $@" > $HOME/scans/katana/$NOW/scan.log
  echo -n "Started: " >> $HOME/scans/katana/$NOW/scan.log
  date >> $HOME/scans/katana/$NOW/scan.log

  echo -n "Source IP: " >> $HOME/scans/katana/$NOW/scan.log
  curl https://ifconfig.me/ >> $HOME/scans/katana/$NOW/scan.log
  echo >> $HOME/scans/katana/$NOW/scan.log
  echo >> $HOME/scans/katana/$NOW/scan.log
  docker run --rm redgo katana $@ >> $HOME/scans/katana/$NOW/scan.log

  echo >> $HOME/scans/katana/$NOW/scan.log
  echo -n "Finished: " >> $HOME/scans/katana/$NOW/scan.log
  date >> $HOME/scans/katana/$NOW/scan.log

  cat $HOME/scans/katana/$NOW/scan.log
}

d.msprobe() {
  docker run -it --rm redgo /root/.local/bin/msprobe $@
}

d.cloudfox() {
  docker run -i --rm redgo /root/cloudfox/cloudfox "$@"
}

d.wbu() {
  docker run -i --rm redgo waybackurls $@
}

d.autorecon() {
  echo "AutoRecon"
  echo "Prepend target file with target/"
  echo
  NOW=`date "+%Y%m%d_%H%M%S"`
  docker run -v `pwd`/${NOW}_autorecon_results:/root/results -v `pwd`:/root/target -it --rm autorecon $@

  # Change ownership
  sudo chown user:users ${NOW}_autorecon_results -R

  # Delete directory if empty
  find ${NOW}_autorecon_results -type d -empty -delete
}

d.gf() {
  docker run -i --rm redgo gf $@
}

d.orbitaldump() {
  docker run -v `pwd`:/mnt -i --rm redgo orbitaldump $@
}

d.nessus() {
  echo -n "Nessus activation code? "
  read NESSUS_ACTIVATION_CODE
  if [[ ! -z "$NESSUS_ACTIVATION_CODE" ]]; then
    echo -n "Stopping existing nessus instance.."
    docker stop nessus
    echo -n "Removing existing nessus instance.."
    docker rm nessus
    docker run --name "nessus" -d -p 127.0.0.1:10100:8834 -e ACTIVATION_CODE=$NESSUS_ACTIVATION_CODE -e USERNAME=admin -e PASSWORD=password tenableofficial/nessus
  else
    echo "ERROR: Provide activation code"
  fi
}

d.rg() {
  if [[ "$#" -lt "1" ]]; then
    echo "ERROR: Must specify at least something like:"
    echo "$0 what <file>"
    return 1
  fi

  docker run --rm -v `pwd`:/root redgo $@
}

d.shell() {
  docker run --rm -it --entrypoint=/bin/bash "$@"
}

d.shellsh() {
  docker run --rm -it --entrypoint=/bin/sh "$@"
}

d.sshere(){
  if [[ "$#" -ne "1" ]]; then
    echo "d.sshere <container-image>"
    return 1
  fi

  docker run -it --rm --name=deepfence-secretscanner -v $(pwd):/home/deepfence/output -v /var/run/docker.sock:/var/run/docker.sock deepfenceio/deepfence_secret_scanner:latest -image-name $1
  screen -adm $HOME/git/maxos/scripts/telegram_notify.sh -a -q -m "Finished SecretScanner on $1"
}

d.shellhere() {
  dirname=${PWD##*/}
  docker run --rm -it --entrypoint=/bin/bash -v $(pwd):/${dirname} -w /${dirname} "$@"
}

d.shellhereport() {
  if [[ "$#" -ne "2" ]]; then
    echo "d.shellhereport <image> <port>"
    return 1
  fi
  dirname=${PWD##*/}
  docker run --rm -it -v $(pwd):/${dirname} -p $2:$2 --entrypoint=/bin/bash "$1"
}

d.shellnamed() {
  echo -n "Instance name? "
  read INSTANCE
  docker run --network host --name $INSTANCE -i -t --entrypoint=/bin/bash "$@"
}

d.shellnamedhere() {
  dirname=${PWD##*/}
  echo -n "Instance name? "
  read INSTANCE
  docker run --network host --name $INSTANCE -it --entrypoint=/bin/bash -v $(pwd):/${dirname} -w /${dirname} "$@"
}

d.shellresume() {
  docker start "$@"
  docker exec -it "$@" /bin/bash
}

d.sherlock() {
  if [[ "$#" -ne "1" ]]; then
    echo "ERROR: Specify username"
    return 1
  fi

  docker run --rm -t theyahya/sherlock "$@"
}

d.phash() {
  python /home/user/git/pentest-tools/psudohash/psudohash.py -cpa -y 1990-2030 -w $@
}

d.sharelatex() {
  sed -i "s#- 80:80#- 127.0.0.1:${PORT_SHARELATEX}:80#g" ${HOME}/git/maxos/repos/misc/overleaf/docker-compose.yml
  sed -i "s#image: sharelatex/sharelatex#image: tuetenk0pp/sharelatex-full#g" ${HOME}/git/maxos/repos/misc/overleaf/docker-compose.yml
  docker-compose -f ${HOME}/git/maxos/repos/misc/overleaf/docker-compose.yml up -d
}

d.sharelatex-kill() {
  docker-compose -f ${HOME}/git/misc/overleaf/docker-compose.yml down
}

d.windowshellhere() {
  docker -c 2019-box run --rm -it -v "C:$(pwd):C:/source" -w "C:/source" "$@"
}

d.hmpaa() {
  docker run --rm -it --net=host --name howmanypeoplearearound howmanypeoplearearound
}

d.dos() {
  docker run --rm mhddos "$@"
}

d.bb() {
  docker run -it --rm ghcr.io/openbb-finance/openbbterminal-poetry:latest
}

d.filebrowserhere() {
  # Security measure
  if [[ "`pwd`" == "$HOME" ]]; then
    echo "ERROR: Not running in $HOME .."
    return 1
  fi

  screen -S filebrowser -adm docker run --rm --name filebrowser -p 1080:80 -v $(pwd):/srv filebrowser/filebrowser
  firefox http://127.0.0.1:1080/ &; disown
}

d.rengine() {
  cd $HOME/git/pentest-tools/rengine
  cp $HOME/git/maxos/resources/rengine/docker-compose.yml .
  sed -i "s#- 443:443/tcp#- ${PORT_RENGINE}:443/tcp#g" ${HOME}/git/pentest-tools/rengine/docker-compose.yml
  sudo make up

  while true; do
    echo -n "Create user for rengine? [yN] "
    read yn
    case $yn in
      [Yy]* ) make username; break;;
      [Nn]* ) break;;
      * ) break;;
    esac
  done
  cd -
}

d.rengine-kill() {
  cd $HOME/git/pentest-tools/rengine
  sudo make down
  git reset --hard
  cd -
}

d.webtop() {
  if [[ "$#" -ne "1" ]]; then
    echo "d.webtop <version-tag>"
    return 1
  fi

  docker run -d \
    --rm \
    --name=webtop-$1 \
    --security-opt seccomp=unconfined `#optional` \
    -e PUID=1000 \
    -e PGID=1000 \
    -e TZ=Europe/London \
    -e SUBFOLDER=/ `#optional` \
    -e KEYBOARD=en-us-qwerty `#optional` \
    -e TITLE=Webtop `#optional` \
    -p 127.0.0.1:10150:3000 \
    -v /path/to/data:/config \
    -v /var/run/docker.sock:/var/run/docker.sock `#optional` \
    --device /dev/dri:/dev/dri `#optional` \
    --shm-size="2gb" `#optional` \
    lscr.io/linuxserver/webtop:$1
}

d.webtop-kill() {
  docker stop `docker ps -a -q -f name=webtop | choose 0`
}

a.alarm() {
  if [[ "$#" -ne "2" ]]; then
    echo "a.alarm 10:00 \"Meeting\""
  else
    echo "/etc/profiles/per-user/user/bin/twmnc -c \"### $2 ###\"" | at $1
  fi
}

d.ivre() {
  sed -i "s#- \"80:80\"#- \"127.0.0.1:${PORT_IVRE}:80\"#g" ${HOME}/git/pentest-tools/ivre/docker/docker-compose.yml
  docker-compose -f ${HOME}/git/pentest-tools/ivre/docker/docker-compose.yml up -d
}

d.ivre-kill() {
  docker-compose -f ${HOME}/git/pentest-tools/ivre/docker/docker-compose.yml down
}

a.localhostrun() {
  if [[ "$#" -ne "1" ]]; then
    echo "Specify port number"
  else
    ssh -R 80:localhost:$1 nokey@localhost.run
  fi
}

a.localhostrun-gotty() {
  if [[ "$#" -lt "1" ]]; then
    echo "ERROR: Specify command"
    return 1
  fi

  TIMESTAMP=`date +%Y%m%d_%H%M%S`
  screen -S ${TIMESTAMP}_testssl -adm gotty --port 9000 $@
  ssh -R 80:localhost:9000 nokey@localhost.run
  screen -S ${TIMESTAMP}_testssl -X quit
}

a.localhostrun-nginx() {
  # Security measure
  if [[ "`pwd`" == "$HOME" ]]; then
    echo "ERROR: Not running in $HOME .."
    return 1
  fi

  docker run --rm --name localhostrun-nginx -d -p 1080:80 -p 8443:443 -v "$(pwd):/srv/data" rflathers/nginxserve
  ssh -R 80:localhost:1080 nokey@localhost.run
  echo "Stopping nginx docker instance.."
  docker stop localhostrun-nginx
}

a.localhostrun-filebrowser() {
  # Security measure
  if [[ "`pwd`" == "$HOME" ]]; then
    echo "ERROR: Not running in $HOME"
    return 1
  fi

  PASSWORD_CLEAR=`pwgen 10`
  echo "####################"
  echo "# Password is $PASSWORD_CLEAR"
  echo "####################"
  echo -n "$PASSWORD_CLEAR" | qrencode -t UTF8

  PASSWORD=`docker run --rm filebrowser/filebrowser hash $PASSWORD_CLEAR`

  docker run --rm --name localhostrun-filebrowser -d -p 1080:80 -v $(pwd):/srv filebrowser/filebrowser \
    --password $PASSWORD

  ssh -R 80:localhost:1080 nokey@localhost.run
  echo "Stopping filebrowser docker instance.."
  docker stop localhostrun-filebrowser
}

a.localhostrun-privatebin() {
  ssh -R 80:localhost:10040 nokey@localhost.run
  echo "Stopping localhost.run connection.."
}

a.cloudmapper-gather() {
  if [[ "$#" -ne "3" ]]; then
    echo "a.cloudmapper-gather <DOCKER_VOLUME> <ACCESS_KEY_ID> <SECRET_ACCESS_KEY>"
    return 1
  fi

  docker run --rm -v ${1}-cloudmapper-account-data:/opt/cloudmapper/account-data \
    -v ${1}-cloudmapper-web:/opt/cloudmapper/web \
    -e AWS_ACCESS_KEY_ID=$2 -e AWS_SECRET_ACCESS_KEY=$3 \
    -p 8000:8000 -it cloudmapper /bin/bash -c \
      "ACCOUNT_ID=\`/usr/bin/aws sts get-caller-identity | jq -r '.Account'\`;  \
      python cloudmapper.py configure add-account --config-file config.json --name client --id \$ACCOUNT_ID ; \
      python cloudmapper.py collect --account client ; \
      python cloudmapper.py report --account client ; \
      python cloudmapper.py prepare --account client ;"
}

a.cloudmapper-serve() {
  if [[ "$#" -ne "3" ]]; then
    echo "a.cloudmapper-serve <DOCKER_VOLUME> <ACCESS_KEY_ID> <SECRET_ACCESS_KEY>"
    return 1
  fi

  # Serve results
  if docker run --rm -v "${1}-cloudmapper-web:/var/lib/nginx/html" -d \
    -p 8101:80 dceoy/nginx-autoindex; then
    dunst-handle "CloudMapper report ready" "http://localhost:8101/account-data/report.html?t=`date +%s`" &; disown
    dunst-handle "CloudMapper prepare ready" "http://localhost:8101/?t=`date +%s`" &; disown
  else
    dunst-handle "Error launching CloudMapper reports"
  fi
}

a.cloudmapper() {
  if [[ "$#" -ne "3" ]]; then
    echo "a.cloudmapper <DOCKER_VOLUME> <ACCESS_KEY_ID> <SECRET_ACCESS_KEY>"
    return 1
  fi

  if docker volume inspect ${1}-cloudmapper-account-data; then
    while true; do
      echo -n "${1}-cloudmapper-account-data docker volume exists, just serve? [Yn] "
      read yn
      case $yn in
        [Yy]* ) a.cloudmapper-serve $@; break;;
        [Nn]* ) a.cloudmapper-gather $@; a.cloudmapper-serve $@; break;;
        * ) a.cloudmapper-serve $@; break;;
      esac
    done
  else
    a.cloudmapper-gather $@
    a.cloudmapper-serve $@
  fi
}

a.scout-gather() {
  if [[ "$#" -ne "4" ]]; then
    echo "a.scout-gather <DOCKER_VOLUME> <ACCESS_KEY_ID> <SECRET_ACCESS_KEY> <SESSION_TOKEN>"
    return 1
  fi

  docker run --rm -v "${1}-scout:/scoutsuite-report" \
    -e AWS_ACCESS_KEY_ID=$2 -e AWS_SECRET_ACCESS_KEY=$3 \
    -it rossja/ncc-scoutsuite /bin/bash -c \
      "/usr/local/bin/scout aws --access-keys --access-key-id $2 \
      --secret-access-key $3 --session-token $4"
}

a.scout-serve() {
  if [[ "$#" -ne "1" ]]; then
    echo "a.scout-serve <DOCKER_VOLUME>"
    return 1
  fi

  if docker run --rm -v "${1}-scout:/var/lib/nginx/html" -d -p 8100:80 \
    dceoy/nginx-autoindex; then
    dunst-handle "Scout report ready" "http://localhost:8100/?t=`date +%s`" &; disown
  else
    dunst-handle "Error launching scout reports"
  fi
}

a.scout() {
  if [[ "$#" -ne "4" ]]; then
    echo "a.scout <DOCKER_VOLUME> <ACCESS_KEY_ID> <SECRET_ACCESS_KEY> <SESSION_TOKEN>"
    return 1
  fi

  if docker volume inspect ${1}-scout; then
    while true; do
      echo -n "${1}-scout docker volume exists, just serve? [Yn] "
      read yn
      case $yn in
        [Yy]* ) a.scout-serve $@; break;;
        [Nn]* ) a.scout-gather $@; a.scout-serve $@; break;;
        * ) a.scout-serve $@; break;;
      esac
    done
  else
    a.scout-gather $@
    a.scout-serve $@
  fi
}

a.aws-security-viz(){
  if [[ "$#" -ne "3" ]]; then
    echo "a.aws-security-viz <DOCKER_VOLUME> <ACCESS_KEY_ID> <SECRET_ACCESS_KEY>"
    return 1
  fi

  if docker run -d --rm -p ${PORT_AWS_SECURITY_VIZ}:8102 -v ${1}-aws-viz:/aws-security-viz \
    --name sec-viz sec-viz /usr/local/bundle/bin/aws_security_viz \
    -a $2 -s $3 --renderer navigator --serve 8102; then
    dunst-handle "aws-security-viz report ready" "http://localhost:8102/navigator.html#aws-security-viz.png" &; disown
  else
    dunst-handle "Error launching aws-security-viz reports"
  fi
}

a.cartography(){
  while true; do
    echo -n "Launch cartography? [yN] "
    read yn
    case $yn in
      [Yy]* ) break;;
      [Nn]* ) return 1; break;;
      * ) return 1; break;;
    esac
  done

  echo "Cartography uses ~/.aws, make sure this is set correctly."
  echo "Press enter to continue."
  read

  cd $HOME/git/maxos-bootstrap/resources/docker/cartography
  docker-compose up -d neo4j
  sleep 3
  docker-compose up -d cartography
  sleep 3
  dunst-handle "Cartography started" "http://localhost:7474" &; disown
  cd -
}

a.prowler-gather() {
  if [[ "$#" -ne "4" ]]; then
    echo "a.prowler-gather <DOCKER_VOLUME> <ACCESS_KEY_ID> <SECRET_ACCESS_KEY> <SESSION_TOKEN>"
    return 1
  fi

  # Permissions fix
  docker volume create ${1}-prowler
  VOL_PATH=`docker inspect ${1}-prowler | jq -r '.[].Mountpoint'`
  if [[ "${VOL_PATH: -6}" == "/_data" ]]; then
    echo "chmod 777 $VOL_PATH"
    sudo chmod 777 $VOL_PATH
  else
    echo "Error with prowler volume"
    read
  fi

  docker run -it --rm --name ${1}-prowler -v ${1}-prowler:/home/prowler/output \
    --env AWS_ACCESS_KEY_ID="${2}" --env AWS_SECRET_ACCESS_KEY="${3}"  --env AWS_SESSION_TOKEN="${4}" \
    toniblyx/prowler:latest -M csv json json-asff html
}

a.prowler-serve() {
  if [[ "$#" -ne "1" ]]; then
    echo "a.prowler-serve <DOCKER_VOLUME>"
    return 1
  fi

  if docker run --rm -v "${1}:/var/lib/nginx/html/prowler" -d -p 8104:80 \
    dceoy/nginx-autoindex; then
    echo "Prowler report ready - http://localhost:8104/prowler/?t=`date +%s`"
  else
    echo "Error launching prowler reports"
  fi
}

a.prowler() {
  if [[ "$#" -ne "4" ]]; then
    echo "a.prowler <DOCKER_VOLUME> <ACCESS_KEY_ID> <SECRET_ACCESS_KEY> <SESSION_TOKEN>"
    return 1
  fi

  if docker volume inspect ${1}-prowler; then
    while true; do
      echo -n "${1}-prowler docker volume exists, just serve? [Yn] "
      read yn
      case $yn in
        [Yy]* ) a.prowler-serve $@; break;;
        [Nn]* ) a.prowler-gather $@; a.prowler-serve $@; break;;
        * ) a.prowler-serve $@; break;;
      esac
    done
  else
    a.prowler-gather $@
    a.prowler-serve $@
  fi
}

a.aws-public-ips() {
  if [[ "$#" -ne "4" ]]; then
    echo "a.aws-public-ips <REGION> <CLIENT> <ACCESS_KEY_ID> <SECRET_ACCESS_KEY>"
    return 1
  fi

  TIMESTAMP=`date +%Y%m%d_%H%M%S`
  WORK_DIR=$HOME/tool-output/aws-public-ips/${TIMESTAMP}_${2}
  mkdir -p $WORK_DIR 2>/dev/null

  RESULTS="`date "+%Y%m%d_%H%M%S"`_${1}_aws_public_ips.txt"
  if docker run --rm \
    -e AWS_REGION="$1" -e AWS_ACCESS_KEY_ID="$3" \
    -e AWS_SECRET_ACCESS_KEY="$4" arkadiyt/aws_public_ips \
    > "$WORK_DIR/$RESULTS"; then
    dunst-handle "aws-public-ips report ready" "file:///$WORK_DIR/$RESULTS" &; disown
  else
    dunst-handle "Error launching aws-public-ips report"
  fi

  while true; do
    echo -n "nmap scan aws-public-ips? [Yn] "
    read yn
    case $yn in
      [Yy]* ) d-nmap -p - `cat $WORK_DIR/$RESULTS`; break;;
      [Nn]* ) break;;
      * ) d-nmap -p - `cat $WORK_DIR/$RESULTS`; break;;
    esac
  done
}

a.cloudsploit() {
  if [[ "$#" -ne "4" ]]; then
    echo "a.cloudsploit <COMPLIANCE_TYPE> <CLIENT> <ACCESS_KEY_ID> <SECRET_ACCESS_KEY>"
    return 1
  fi

  TIMESTAMP=`date +%Y%m%d_%H%M%S`
  WORK_DIR=$HOME/tool-output/cloudsploit/${TIMESTAMP}_${2}
  mkdir -p $WORK_DIR 2>/dev/null

  RESULTS="`date "+%Y%m%d_%H%M%S"`_${1}_cloudsploit.txt"
  if docker run --rm -e AWS_ACCESS_KEY_ID=$3 -e AWS_SECRET_ACCESS_KEY=$4 \
    --entrypoint="/var/scan/node_modules/.bin/cloudsploitscan" cloudsploit:0.0.1 \
    --compliance=$1 > "$WORK_DIR/$RESULTS"; then
    dunst-handle "cloudsploit (${1}) report ready" "file:///$WORK_DIR/$RESULTS" &; disown
  else
    dunst-handle "Error launching cloudsploit report"
  fi
}

###
### Lazy boy
###
awsscan() {
  CONFIG_FILE="aws.secrets"

  # If no aws.secrets, vim
  if [[ ! -f $CONFIG_FILE ]]; then
    ENTROPY=`uuidgen | choose -f '-' 0`
    echo "export AWS_ACCESS_KEY_ID=\"\"
export AWS_SECRET_ACCESS_KEY=\"\"
export AWS_SESSION_TOKEN=\"\"
export AWS_REGION=\"\"
export CLIENT=\"\"
export DOCKER_VOLUME=\"awsscan_$ENTROPY\"" > $CONFIG_FILE
    vim $CONFIG_FILE
  fi

  source $CONFIG_FILE

  #if [[ "$#" -ne "5" ]]; then
  #  echo "awsscan <REGION> <DOCKER_VOLUME> <ACCESS_KEY_ID> <SECRET_ACCESS_KEY> <SESSION_TOKEN>"
  #  return 1
  #fi

  echo "Starting scans.."
  #echo "###"
  #echo "### Cartography"
  #echo "###"
  #echo a.cartography
  echo "###"
  echo "### cloudsploit"
  echo "###"
  echo a.cloudsploit cis $DOCKER_VOLUME $AWS_ACCESS_KEY_ID $AWS_SECRET_ACCESS_KEY
  echo a.cloudsploit pci $DOCKER_VOLUME $AWS_ACCESS_KEY_ID $AWS_SECRET_ACCESS_KEY
  echo "###"
  echo "### aws-security-viz"
  echo "###"
  echo a.aws-security-viz $DOCKER_VOLUME $AWS_ACCESS_KEY_ID $AWS_SECRET_ACCESS_KEY
  echo "###"
  echo "### Scout"
  echo "###"
  echo a.scout $DOCKER_VOLUME $AWS_ACCESS_KEY_ID $AWS_SECRET_ACCESS_KEY $AWS_SESSION_TOKEN
  echo "###"
  echo "### CloudMapper"
  echo "###"
  echo a.cloudmapper $DOCKER_VOLUME $AWS_ACCESS_KEY_ID $AWS_SECRET_ACCESS_KEY
  echo "###"
  echo "### Prowler"
  echo "###"
  echo a.prowler $DOCKER_VOLUME $AWS_ACCESS_KEY_ID $AWS_SECRET_ACCESS_KEY $AWS_SESSION_TOKEN
  echo "###"
  echo "### aws-public-ips"
  echo "###"
  echo a.aws-public-ips $AWS_REGION $DOCKER_VOLUME $AWS_ACCESS_KEY_ID $AWS_SECRET_ACCESS_KEY
}

awsscan-collate() {
  if [[ "$#" -ne "1" ]]; then
    echo "awsscan-collate <CLIENT>"
    return 1
  fi

  PATH_AWS_VIZ=`docker inspect ${1}-aws-viz | jq -r '.[].Mountpoint'`
  PATH_CLOUDMAPPER_ACCOUNT_DATA=`docker inspect ${1}-cloudmapper-account-data | jq -r '.[].Mountpoint'`
  PATH_CLOUDMAPPER_WEB=`docker inspect ${1}-cloudmapper-web | jq -r '.[].Mountpoint'`
  PATH_PROWLER=`docker inspect ${1}-prowler | jq -r '.[].Mountpoint'`
  PATH_SCOUT=`docker inspect ${1}-scout | jq -r '.[].Mountpoint'`

  if [[ ${PATH_AWS_VIZ: -6} != "/_data" || \
      ${PATH_CLOUDMAPPER_ACCOUNT_DATA: -6} != "/_data" || \
      ${PATH_CLOUDMAPPER_WEB: -6} != "/_data" || \
      ${PATH_PROWLER: -6} != "/_data" || \
      ${PATH_SCOUT: -6} != "/_data" ]]; then
    echo "Issue assigning docker volume mountpoint variables, check them"
    return 1
  fi

  TIMESTAMP=`date +%Y%m%d_%H%M%S`
  mkdir ${TIMESTAMP}_${1}_data
  mkdir ${TIMESTAMP}_${1}_data/aws_viz
  mkdir ${TIMESTAMP}_${1}_data/cloudmapper-account-data
  mkdir ${TIMESTAMP}_${1}_data/cloudmapper-web
  mkdir ${TIMESTAMP}_${1}_data/prowler
  mkdir ${TIMESTAMP}_${1}_data/scout
  mkdir ${TIMESTAMP}_${1}_data/cloudsploit
  mkdir ${TIMESTAMP}_${1}_data/aws-pbulic-ips

  sudo cp -rf $PATH_AWS_VIZ ${TIMESTAMP}_${1}_data/aws_viz
  sudo cp -rf $PATH_CLOUDMAPPER_ACCOUNT_DATA ${TIMESTAMP}_${1}_data/cloudmapper-account-data
  sudo cp -rf $PATH_CLOUDMAPPER_WEB ${TIMESTAMP}_${1}_data/cloudmapper-web
  # So people can find account-data
  sudo mv ${TIMESTAMP}_${1}_data/cloudmapper-web/_data/index.html ${TIMESTAMP}_${1}_data/cloudmapper-web/_data/viz.html
  sudo cp -rf $PATH_PROWLER ${TIMESTAMP}_${1}_data/prowler
  sudo cp -rf $PATH_SCOUT ${TIMESTAMP}_${1}_data/scout
  sudo cp -rf ${HOME}/tool-output/aws-public-ips/*${1} ${TIMESTAMP}_${1}_data/aws-pbulic-ips
  sudo cp -rf ${HOME}/tool-output/cloudsploit/*${1} ${TIMESTAMP}_${1}_data/cloudsploit

  AWS_COLLATE_PASSWORD=`pwgen 20`
  sudo zip -q -r -P $AWS_COLLATE_PASSWORD ${TIMESTAMP}-${1}.zip ${TIMESTAMP}_${1}_data
  echo "Password for ${TIMESTAMP}-${1}.zip is $AWS_COLLATE_PASSWORD"

  sudo rm -rf ./${TIMESTAMP}_${1}_data

  #echo $PATH_AWS_VIZ
  #echo $PATH_CLOUDMAPPER_ACCOUNT_DATA
  #echo $PATH_CLOUDMAPPER_WEB
  #echo $PATH_PROWLER
  #echo $PATH_SCOUT
}

# Fast port / web scans
fscan() {
  if [[ "$#" -ne "2" ]]; then
    echo "fscan <IP> <URL>"
    echo "Example: fscan 10.0.0.1 http://10.0.0.1:1337"
    return 1
  else
    /run/current-system/sw/bin/urxvt -bg black -fg white -e "$HOME/git/maxos-bootstrap/scripts/fscan_left.sh" "$@" &
    disown
    /run/current-system/sw/bin/urxvt -bg black -fg white -e "$HOME/git/maxos-bootstrap/scripts/fscan_right.sh" "$@" &
    disown
  fi
}

# Windows services scan (port 139 / 445)
wscan() {
  if [[ "$#" -ne "1" ]]; then
    echo "wscan <IP>"
    echo "Example: wscan 10.0.0.1"
    return 1
  else
    /run/current-system/sw/bin/urxvt -bg black -fg white -e "$HOME/git/maxos-bootstrap/scripts/wscan_left.sh" "$@" &
    disown
    /run/current-system/sw/bin/urxvt -bg black -fg white -e "$HOME/git/maxos-bootstrap/scripts/wscan_right.sh" "$@" &
    disown
  fi
}

webscan() {
  d-sniper -c "sniper -t \"$@\""
  d-nikto "$@"
  d-feroxbuster-slow "$@"
  d-arjun "$@"
  d-spiderfoot
  d-testssl
  # nuclei
  CONTENT="$@ completed"
  notify-desktop "webscan - $CONTENT"
}

osint() {
  # Misc
  firefox https://www.faganfinder.com/
  # Search engines
  TOOLS=("https://www.ask.com/web?q=site%3A" \
       "https://duckduckgo.com/?q=site%3A" \
       "http://gigablast.com/search?q=" \
       "https://search.lycos.com/web/?q=site%3A" \
       "https://uk.search.yahoo.com/search?p=site%3A" \
       "https://www.shodan.io/search?query=" \
       "https://www.alltheinternet.com/?q=site%3A" \
       "https://www.qwant.com/?q=site%3A" \
       "https://swisscows.com/web?query=site%253A" \
       "https://millionshort.com/search?keywords=" \
       "https://buckets.grayhatwarfare.com/results/" \
       "https://www.courtlistener.com/?q=" \
       "http://www.freefullpdf.com/#gsc.q=tinder.com" \
       "https://offshoreleaks.icij.org/search?q=" \
       "https://grep.app/search?q=" \
       "https://web.archive.org/web/*/")

  for TOOL in $TOOLS
  do
    for OUTPUT in $@
    do
      # Only one domain at a time
      firefox "${TOOL}${OUTPUT}"
    done
  done

  for OUTPUT in $@
  do
    SITE_STRING="${SITE_STRING}site:${OUTPUT}%20OR%20"
  done

  GOOGLE_STRING="https://www.google.com/search?q=$SITE_STRING"
  BING_STRING="https://www.bing.com/search?q=$SITE_STRING"
  firefox $GOOGLE_STRING
  firefox $BING_STRING
}

###
### Tools
###
d.vpn() {
  docker run -d --rm --cap-add=NET_ADMIN \
    --volume ${HOME}/vpn:/etc/wireguard/:ro \
    -p 127.0.0.1:1080:1080 \
    kizzx2/wireguard-socks-proxy
}

d.vpn-array() {
  if [[ "$#" -ne "1" ]]; then
    echo "d.vpn-array <instance-count>"
    return 1
  fi
  rm -rf ${HOME}/vpn/tmp_*

  for i in {1..$1}
  do
    mkdir ${HOME}/vpn/tmp_${i}
    RAND_CONF=`ls ${HOME}/vpn/*.conf |sort -R |tail -1`
    cp ${RAND_CONF} ${HOME}/vpn/tmp_${i}
    PORT_1080=$(expr 1080 + $i)

    docker run -d --rm --cap-add=NET_ADMIN \
      --volume ${HOME}/vpn/tmp_${i}:/etc/wireguard/:ro \
      -p 127.0.0.1:${PORT_1080}:1080 \
      kizzx2/wireguard-socks-proxy
  done

  PORT_1080_FIRST=$(expr 1080 + 1)
  PORT_1080_LAST=$(expr 1080 + $1)

  echo "VPN ports"
  echo "#########"
  echo "First instance"
  echo "1080 == ${PORT_1080_FIRST}"
  echo "Last instance"
  echo "1080 == ${PORT_1080_LAST}"
}

d.vpn-array-kill() {
  INSTANCES=$(docker ps -q -f "ancestor=kizzx2/wireguard-socks-proxy")
  if [[ "$INSTANCES" == "" ]]; then
    echo "No VPN instances to stop"
  else
    docker ps -q -f "ancestor=kizzx2/wireguard-socks-proxy" | xargs docker stop
  fi
}

d.tor() {
  docker run --rm -it -p 127.0.0.1:8118:8118 \
    -p 127.0.0.1:9050:9050 \
    -p 127.0.0.1:9051:9051 \
    -d dperson/torproxy
}

d.tor-array() {
  if [[ "$#" -ne "1" ]]; then
    echo "d.tor-array <instance-count>"
    return 1
  fi

  for i in {1..$1}
  do
    PORT_8118=$(expr 8118 + $i)
    PORT_9050=$(expr 9050 + $i)
    PORT_10051=$(expr 10051 + $i)
    docker run --rm -it -e TOR_ControlPort=0.0.0.0:9051 \
      -p 127.0.0.1:$PORT_8118:8118 \
      -p 127.0.0.1:$PORT_9050:9050 \
      -p 127.0.0.1:$PORT_10051:9051 \
      -d dperson/torproxy -p password
  done

  PORT_8118_FIRST=$(expr 8118 + 1)
  PORT_9050_FIRST=$(expr 9050 + 1)
  PORT_10051_FIRST=$(expr 10051 + 1)

  PORT_8118_LAST=$(expr 8118 + $1)
  PORT_9050_LAST=$(expr 9050 + $1)
  PORT_10051_LAST=$(expr 10051 + $1)

  echo "Tor ports"
  echo "#########"
  echo "First instance"
  echo "8118 == ${PORT_8118_FIRST}\t9050 == ${PORT_9050_FIRST}\t9051 == ${PORT_10051_FIRST}"
  echo "Last instance"
  echo "8118 == ${PORT_8118_LAST}\t9050 == ${PORT_9050_LAST}\t9051 == ${PORT_10051_LAST}"
}

d.tor-array-kill() {
  INSTANCES=$(docker ps -q -f "ancestor=dperson/torproxy")
  if [[ "$INSTANCES" == "" ]]; then
    echo "No tor instances to stop"
  else
    docker ps -q -f "ancestor=dperson/torproxy" | xargs docker stop
  fi
}

d.pcf() {
  docker-compose -f $HOME/git/pentest-tools/pcf/docker-compose.yml up
}

d.testssl() {
  if [[ "$#" -ne "1" ]]; then
    echo "d.testssl <url>"
    return 1
  fi

  TIMESTAMP=`date +%Y%m%d_%H%M%S`
  WORK_DIR=$HOME/tool-output/testssl/$TIMESTAMP
  mkdir -p $WORK_DIR 2>/dev/null
  screen -S ${TIMESTAMP}_testssl -adm testssl.sh \
    -oL ${WORK_DIR}/${TIMESTAMP}_testssl.txt \
    -oj ${WORK_DIR}/${TIMESTAMP}_testssl.json \
    -oH ${WORK_DIR}/${TIMESTAMP}_testssl.html "$1"
  #CONTENT="$@ completed"
  #notify-desktop "testssl - $CONTENT"
}

d.tlsmate() {
  if [[ "$#" -ne "1" ]]; then
    echo "d.tlsmate <url>"
    return 1
  fi

  docker run --rm -it guballa/tlsmate tlsmate scan \
    --progress $1
}

d.nuclei() {
  docker run --rm -v $(pwd):/mnt projectdiscovery/nuclei $@
}

d.eth-security-toolbox() {
  docker run -it --rm -v $(pwd):/share trailofbits/eth-security-toolbox
}

d.myth() {
  if [[ "$#" -ne "2" ]]; then
    echo "d.myth <file> <solv>"
    return 1
  fi

  TIMESTAMP=`date +%Y%m%d_%H%M%S`
  WORK_DIR=$HOME/tool-output/myth/$TIMESTAMP
  mkdir -p $WORK_DIR 2>/dev/null
  docker run -it --rm -v $(pwd):/home/mythril/sol mythril/myth a sol/$1 --solv $2 > $WORK_DIR/${TIMESTAMP}_myth
  CONTENT="$@ completed"
  notify-dekstop "myth - $CONTENT"
}

d.thelounge() {
  screen -S thelounge -adm docker run --rm -it --name thelounge -e PUID=1000 -e PGID=1000 -e TZ=Europe/London -p 127.11.0.1:9000:9000 -v $HOME/.config/thelounge:/config ghcr.io/linuxserver/thelounge
  firefox http://127.11.0.1:9000 &; disown
}

d.stego-toolkit() {
  docker run --rm -it --name stego-toolkit -v $(pwd):/data dominicbreuker/stego-toolkit /bin/bash "$@"
}

d.bettercap() {
  docker run --rm -it --name bettercap --net=host bettercap/bettercap
}

d.ciphey() {
  docker run -it --rm --name ciphey -v $(pwd):/home/nonroot/workdir remnux/ciphey "$@"
}

d.astra() {
  docker run --rm -d --name astra-mongo mongo
  cd $HOME/git/pentest-tools/Astra
  docker build -t astra .
  docker run --rm -d -it --link astra-mongo:mongo -p 8094:8094 astra
  firefox http://localhost:8094 &; disown
}

d.openvas() {
  docker run -p ${PORT_OPENVAS}:443 --name openvas greenbone/openvas
}

d.beef() {
  mkdir -p $HOME/.msf4
  docker run --rm -it --net=host -v $HOME/.msf4:/root/.msf4:Z -v /tmp/msf:/tmp/data:Z --name=beef phocean/beef
}

d.eyewitness() {
  TIMESTAMP=`date +%Y%m%d_%H%M%S`
  docker run --rm -it -v $PWD:/tmp/EyeWitness eyewitness -f /tmp/EyeWitness/$@ -d /tmp/EyeWitness/eyewitness_$TIMESTAMP
  CONTENT="$@ completed"
  dunst-handle "EyeWitness - $CONTENT" "file:///$PWD/eyewitness_$TIMESTAMP/report.html" &; disown
}

d.screenshot() {
  if [[ "$#" -lt "2" ]]; then
    echo "d.screenshot <screenshot|full_screenshot|screenshot_series|full_screenshot_series> <URL> [resolution] [delay]"
    return 1
  fi

  docker run --shm-size 1G --rm -v $PWD:/screenshots alekzonder/puppeteer:latest $@
}

d.cyberchef() {
  docker run --rm -d -p ${PORT_CYBERCHEF}:8000 mpepping/cyberchef
  firefox http://localhost:${PORT_CYBERCHEF} &; disown
}

d.feroxbuster() {
  TIMESTAMP=`date +%Y%m%d_%H%M%S`
  WORK_DIR=$HOME/tool-output/feroxbuster/$TIMESTAMP
  LOOT_DIR="/mnt"
  LOOT_FILE="/mnt/feroxbuster.log"
  mkdir -p $WORK_DIR 2>/dev/null
  docker run --rm -v $WORK_DIR:$LOOT_DIR --net=host --init -it epi052/feroxbuster --auto-tune -k -r -u "$@" -x js,html -o $LOOT_FILE
  CONTENT="$@ completed"
  notify-desktop "feroxbuster - $CONTENT"
}

d.feroxbuster-slow() {
  d-feroxbuster "$@" -L 2 -t 2
  CONTENT="$@ completed"
  notify-desktop "feroxbuster-slow - $CONTENT"
}

d.hetty() {
  docker run --rm -v $HOME/.hetty:/root/.hetty -p 8080:8080 dstotijn/hetty
}

d.spiderfoot(){
  docker run --rm -p ${PORT_SPIDERFOOT}:5001 spiderfoot
  firefox http://127.0.0.1:${PORT_SPIDERFOOT} &; disown
}

d.arjun(){
  if [[ "$#" -lt "1" ]]; then
    echo "d.arjun <URL>"
    return 1
  fi

  TIMESTAMP=`date +%Y%m%d_%H%M%S`
  WORK_DIR=$HOME/tool-output/arjun/$TIMESTAMP
  LOOT_DIR="/mnt"
  mkdir -p $WORK_DIR 2>/dev/null
  docker run --rm -v $WORK_DIR:$LOOT_DIR arjun -u "$@" -oT $LOOT_DIR/arjun.txt -oJ $LOOT_DIR/arjun.json
  CONTENT="$@ completed"
  notify-desktop "arjun - $CONTENT"
}

d.sniper() {
  TIMESTAMP=`date +%Y%m%d_%H%M%S`
  WORK_DIR=$HOME/tool-output/sn1per/$TIMESTAMP
  LOOT_DIR="/usr/share/sniper/loot/workspace"
  mkdir -p $WORK_DIR 2>/dev/null
  docker run --rm -v $WORK_DIR:$LOOT_DIR -it xerosecurity/sn1per /bin/bash "$@"
  CONTENT="$@ completed"
  notify-desktop "sniper - $CONTENT"
}

d.impacket() {
  docker run --rm -it rflathers/impacket "$@"
}

d.smbservehere() {
  # Security measure
  if [[ "`pwd`" == "$HOME" ]]; then
    echo "ERROR: Not running in $HOME .."
    return 1
  fi

  local sharename
  [[ -z $1 ]] && sharename="SHARE" || sharename=$1
  docker run --rm -it -p 445:445 -v "$(pwd):/tmp/serve" rflathers/impacket smbserver.py -smb2support $sharename /tmp/serve
}

d.nginxconfig() {
  if [[ ! -f "./default.conf" ]]; then
    echo "ERROR: ./default.conf not found"
    return 1
  fi

  docker run --rm -p 1080:1080 -v "$(pwd)/default.conf:/etc/nginx/conf.d/default.conf:ro" nginx
}

d.pythonhere() {
  docker run --rm -it -v "$(pwd):/mnt" python /bin/bash
}

d.nginxhere() {
  # Security measure
  if [[ "`pwd`" == "$HOME" ]]; then
    echo "ERROR: Not running in $HOME .."
    return 1
  fi

  screen -S nginxhere -adm docker run --rm -it -p 1080:80 -p 443:443 -v "$(pwd):/srv/data" rflathers/nginxserve
  sleep 2
  firefox http://127.0.0.1:1080 &; disown
}

d.miniservehere() {
  # Security measure
  if [[ "`pwd`" == "$HOME" ]]; then
    echo "ERROR: Not running in $HOME .."
    return 1
  fi

  screen -S miniservehere -adm docker run -v "$(pwd):/tmp" -p 10210:8080 --rm -it docker.io/svenstaro/miniserve -grz /tmp
  sleep 2
  firefox http://127.0.0.1:10210 &; disown
}

d.webdavhere() {
  # Security measure
  if [[ "`pwd`" == "$HOME" ]]; then
    echo "ERROR: Not running in $HOME .."
    return 1
  fi

  docker run --rm -it -p 1080:80 -v "$(pwd):/srv/data/share" rflathers/webdav
}

d.metasploit() {
  mkdir -p $HOME/.msf4
  docker run --rm -it -v "${HOME}/.msf4:/home/msf/.msf4" metasploitframework/metasploit-framework ./msfconsole "$@"
}

d.metasploitports() {
  mkdir -p $HOME/.msf4
  docker run --rm -it -v "${HOME}/.msf4:/home/msf/.msf4" -p 8080-8085:8080-8085 metasploitframework/metasploit-framework ./msfconsole "$@"
}

d.msfvenomhere() {
  mkdir -p $HOME/.msf4
  docker run --rm -it -v "${HOME}/.msf4:/home/msf/.msf4" -v "$(pwd):/data" metasploitframework/metasploit-framework ./msfvenom "$@"
}

d.reqdump() {
  docker run --rm -it -p 1080:3000 rflathers/reqdump
}

d.postfiledumphere() {
  docker run --rm -it -p 1080:3000 -v "$(pwd):/data" rflathers/postfiledump
}

d.kali() {
  docker run -it --rm booyaabes/kali-linux-full /bin/bash "$@"
}

d.kalihere() {
  dirname=${PWD##*/}
  docker run -it --rm -v "$(pwd):/${dirname}" -w /${dirname} booyaabes/kali-linux-full /bin/bash
}

d.dirb() {
  docker run -it --rm -w /data -v $(pwd):/data booyaabes/kali-linux-full dirb "$@"
}

d.enum4linux() {
  docker run -it --rm -w /data -v $(pwd):/data booyaabes/kali-linux-full enum4linux -a "$@"
}

d.nbtscan() {
  docker run -it --rm -w /data -v $(pwd):/data booyaabes/kali-linux-full nbtscan -r "$@"
}

d.dnschef() {
  docker run -it --rm -w /data -v $(pwd):/data --net=host booyaabes/kali-linux-full dnschef "$@"
}

d.hping3() {
  docker run -it --rm -w /data -v $(pwd):/data booyaabes/kali-linux-full hping3 "$@"
}

d.rpcclient() {
  docker run -it --rm --net=host booyaabes/kali-linux-full rpcclient -U "" -N "$@" -c querydispinfo
  docker run -it --rm --net=host booyaabes/kali-linux-full rpcclient -U "" -N "$@" -c enumdomusers
}

d.responder() {
  docker run -it --rm --net=host booyaabes/kali-linux-full responder "$@"
}

d.smbclient() {
  if [[ "$#" -lt "1" ]]; then
    echo "d.smbclient <IP>"
    return 1
  fi

  shares=('C$' 'D$' 'ADMIN$' 'IPC$' 'PRINT$' 'FAX$' 'SYSVOL' 'NETLOGON')

  for share in ${shares[*]}; do
    output=$(docker run -it --rm --net=host booyaabes/kali-linux-full smbclient -U '%' -N \\\\$@\\$share -c '')

    if [[ -z $output ]]; then
      # no output if command goes through, assuming that a session was created
      echo "[+] creating a null session is possible for $share"
    else
      # echo error message
      echo $output
    fi
  done
}

d.nikto() {
  TIMESTAMP=`date +%Y%m%d_%H%M%S`
  WORK_DIR=$HOME/tool-output/nikto/$TIMESTAMP
  LOOT_DIR="/data"
  mkdir -p $WORK_DIR 2>/dev/null
  docker run -it --rm --net=host -w $LOOT_DIR -v $WORK_DIR:$LOOT_DIR sullo/nikto \
    -ask No -nointeractive -h "$@" -o $LOOT_DIR/nikto.txt
  CONTENT="$@ completed"
  notify-desktop "nikto - $CONTENT"
}

d.nmap() {
  TIMESTAMP=`date +%Y%m%d_%H%M%S`
  WORK_DIR=$HOME/tool-output/nmap/$TIMESTAMP
  LOOT_DIR="/mnt"
  mkdir -p $WORK_DIR 2>/dev/null
  if docker run --rm -v $WORK_DIR:/mnt --net=host --privileged booyaabes/kali-linux-full nmap -oA /mnt/$TIMESTAMP "$@"; then
    dunst-handle "nmap report ready" "file:///$WORK_DIR" &; disown
  else
    dunst-handle "Error launching nmap reports"
  fi
}

d.nmap-smb() {
  docker run -it --rm -w /data -v $(pwd):/data booyaabes/kali-linux-full nmap --script "safe or smb-enum-*" -p 445 "$@"
}

d.rustscan() {
  docker run --rm cmnatic/rustscan:debian-buster rustscan $@
}

d.searchsploit() {
  docker run --rm booyaabes/kali-linux-full searchsploit $@
}

d.wpscan() {
  if [[ "$#" -ne "2" ]]; then
    echo "d.wpscan <URL> <WPSCAN_API_TOKEN>"
    return 1
  fi

  docker run --rm wpscanteam/wpscan --url $1 --api-token $2 --enumerate p,u --plugins-detection aggressive
}

d.whatweb() {
  docker run --rm guidelacour/whatweb ./whatweb $@
}

d.apkleaks() {
  if [[ "$#" -ne "1" ]]; then
    echo "d.apkleaks <APK>"
    return 1
  fi

  dirname=${PWD##*/}
  docker run -it --rm -v $(pwd):/${dirname} apkleaks -f /${dirname}/$1
}

d.mobsf() {
  docker run --rm -d -p ${PORT_MOBSF}:8000 opensecurity/mobile-security-framework-mobsf
  firefox http://localhost:${PORT_MOBSF} &; disown
}

d.ffuf() {
  if [[ "$#" -ne "2" ]]; then
    echo "d.ffuf <wordlist> <url>"
    return 1
  fi

  TIMESTAMP=`date +"%Y%m%d_%H%M%S"`
  DOMAIN=`echo $2 | gawk -F "/" '{ print $3 }'`

  WORK_DIR=$HOME/tool-output/ffuf/${TIMESTAMP}_${DOMAIN}
  mkdir -p $WORK_DIR 2>/dev/null
  ffuf -recursion -recursion-depth 2 -ac -sf -of all -w $1 -u $2 -od $WORK_DIR

  echo "ffuf finished, results in $WORK_DIR"
}

###
### Educational docker images
###
d.lab-start() {
  d.pygoat
  d.bodgeit
  d.altoro
  d.dvna
  d.dvwa
  d.dvga
  d.vulnerablewordpress
  d.vaas-cve-2014-6271
  d.vaas-cve-2014-0160
  d.webgoat
  d.nowasp
  d.juice-shop
  d.hackazon
  d.tiredful
  d.xvwa
  d.security-ninjas
}

d.lab-kill() {
   docker stop vulnerablewordpress \
         pygoat \
         bodgeit \
         dvna \
         dvga \
         nowasp \
         juice-shop \
         webgoat \
         vaas-cve-2014-6271 \
         vaas-cve-2014-0160 \
         altoro \
         dvwa \
         hackazon \
         tiredful \
         xvwa \
         security-ninjas
}

d.pwsh() {
  dirname=${PWD##*/}
  docker run -it --rm -v $(pwd):/${dirname} -w /${dirname} mcr.microsoft.com/powershell
}

d.altoro() {
  echo "screen -r altoro"
  screen -S altoro -adm docker run --rm --name altoro -p 127.10.0.1:1080:8080 eystsen/altoro
}

d.securityshepherd(){
  docker run -i -p 1080:80 -p 8443:443 ismisepaul/securityshepherd /bin/bash
}

d.pygoat() {
  echo "screen -r pygoat"
  screen -S pygoat -adm docker run --rm --name pygoat -p 127.10.0.16:1080:8000 pygoat/pygoat
}

d.bodgeit() {
  echo "screen -r bodgeit"
  screen -S bodgeit -adm docker run --rm --name bodgeit -p 127.10.0.15:1080:8080 psiinon/bodgeit
}

d.dvna() {
  echo "screen -r dvna"
  screen -S dvna -adm docker run --rm --name dvna -p 127.10.0.13:1080:9090 appsecco/dvna:sqlite
}

d.dvga() {
  echo "screen -r dvga"
  screen -S dvga -adm docker run --rm --name dvga -p 127.10.0.14:1080:5013 -e WEB_HOST=0.0.0.0 dolevf/dvga
}

d.dvwa() {
  echo "screen -r dvwa"
  screen -S dvwa -adm docker run --rm --name dvwa -p 127.10.0.2:1080:80 citizenstig/dvwa
}

d.vulnerablewordpress() {
  echo "screen -r vulnerablewordpress"
  screen -S vulnerablewordpress -adm docker run --rm --name vulnerablewordpress -p 127.10.0.3:1080:80 -p 3306:3306 l505/vulnerablewordpress
}

d.vaas-cve-2014-6271() {
  echo "screen -r vaas-cve-2014-6271"
  screen -S vaas-cve-2014-6271 -adm docker run --rm --name vaas-cve-2014-6271 -p 127.10.0.4:1080:80 hmlio/vaas-cve-2014-6271
}

d.vaas-cve-2014-0160() {
  echo "screen -r vaas-cve-2014-0160"
  screen -S vaas-cve-2014-0160 -adm docker run --rm --name vaas-cve-2014-0160 -p 127.10.0.5:8443:443 hmlio/vaas-cve-2014-0160
}

d.webgoat() {
  echo "screen -r webgoat"
  screen -S webgoat -adm docker run --rm --name webgoat -p 127.10.0.6:1080:8080 --name webgoat -it danmx/docker-owasp-webgoat
}

d.nowasp() {
  echo "screen -r nowasp"
  screen -S nowasp -adm docker run --rm --name nowasp -p 127.10.0.7:1080:80 citizenstig/nowasp
}

d.juice-shop() {
  echo "screen -r juice-shop"
  screen -S juice-shop -adm docker run --rm --name juice-shop -p 127.10.0.8:1080:3000 bkimminich/juice-shop
}

d.hackazon() {
  echo "screen -r hackazon"
  screen -S hackazon -adm docker run --rm --name hackazon -p 127.10.0.9:1080:80 mutzel/all-in-one-hackazon:postinstall supervisord -n
}

d.tiredful() {
  echo "screen -r tiredful"
  screen -S tiredful -adm docker run --rm --name tiredful -p 127.10.0.10:1080:8000 tuxotron/tiredful-api
}

d.xvwa() {
  echo "screen -r xvwa"
  screen -S xvwa -adm docker run --rm --name xvwa -p 127.10.0.11:1080:80 tuxotron/xvwa
}

d.security-ninjas() {
  echo "screen -r security-ninjas"
  screen -S security-ninjas -adm docker run --rm --name security-ninjas -p 127.10.0.12:1080:80 opendns/security-ninjas
}

# extract
a.extract () {
  if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
  else
    if [ -f $1 ] ; then
      # NAME=${1%.*}
      # mkdir $NAME && cd $NAME
      case $1 in
        *.tar.bz2)   tar xvjf ./$1  ;;
        *.tar.gz)  tar xvzf ./$1  ;;
        *.tar.xz)  tar xvJf ./$1  ;;
        *.lzma)    unlzma ./$1    ;;
        *.bz2)     bunzip2 ./$1   ;;
        *.rar)     unrar x -ad ./$1 ;;
        *.gz)    gunzip ./$1    ;;
        *.tar)     tar xvf ./$1   ;;
        *.tbz2)    tar xvjf ./$1  ;;
        *.tgz)     tar xvzf ./$1  ;;
        *.zip)     unzip ./$1     ;;
        *.Z)     uncompress ./$1  ;;
        *.7z)    7z x ./$1    ;;
        *.xz)    unxz ./$1    ;;
        *.exe)     cabextract ./$1  ;;
        *)       echo "extract: '$1' - unknown archive method" ;;
      esac
    else
      echo "$1 - file does not exist"
    fi
  fi
}

###
###
### awesome-stacks
###
###
ds.net-traefik() {
  docker network create --driver=overlay traefik-net
  docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/traefik.yml traefik
}

# appwrite
ds.appwrite() {
  ds-net-traefik
  DOMAIN=appwrite.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/appwrite.yml appwrite
  firefox https://appwrite.ds &; disown
  watch docker stack ps appwrite
}

ds.appwrite-kill() {
  docker stack rm appwrite
  sleep 6
  docker volume prune
}

# bibliogram
ds.bibliogram() {
  ds-net-traefik
  DOMAIN=bibliogram.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/bibliogram.yml bibliogram
  firefox https://bibliogram.ds &; disown
  watch docker stack ps bibliogram
}

ds.bibliogram-kill() {
  docker stack rm bibliogram
  sleep 6
  docker volume prune
}

# bookstack
ds.bookstack() {
  ds-net-traefik
  DOMAIN=bookstack.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/bookstack.yml bookstack
  firefox https://bookstack.ds &; disown
  watch docker stack ps bookstack
}

ds.bookstack-kill() {
  docker stack rm bookstack
  sleep 6
  docker volume prune
}

# botpress
ds.botpress() {
  ds-net-traefik
  DOMAIN=botpress.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/botpress.yml botpress
  firefox https://botpress.ds &; disown
  watch docker stack ps botpress
}

ds.botpress-kill() {
  docker stack rm botpress
  sleep 6
  docker volume prune
}

# calibre
ds.calibre() {
  ds-net-traefik
  DOMAIN=calibre.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/calibre.yml calibre
  firefox https://calibre.ds &; disown
  watch docker stack ps calibre
}

ds.calibre-kill() {
  docker stack rm calibre
  sleep 6
  docker volume prune
}

# chatwoot
ds.chatwoot() {
  ds-net-traefik
  DOMAIN=chatwoot.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/chatwoot.yml chatwoot
  firefox https://chatwoot.ds &; disown
  watch docker stack ps chatwoot
}

ds.chatwoot-kill() {
  docker stack rm chatwoot
  sleep 6
  docker volume prune
}

# commento
ds.commento() {
  ds-net-traefik
  DOMAIN=commento.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/commento.yml commento
  firefox https://commento.ds &; disown
  watch docker stack ps commento
}

ds.commento-kill() {
  docker stack rm commento
  sleep 6
  docker volume prune
}

# crater
ds.crater() {
  ds-net-traefik
  DOMAIN=crater.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/crater.yml crater
  firefox https://crater.ds &; disown
  watch docker stack ps crater
}

ds.crater-kill() {
  docker stack rm crater
  sleep 6
  docker volume prune
}

# cryptpad
ds.cryptpad() {
  ds-net-traefik
  DOMAIN=cryptpad.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/cryptpad.yml cryptpad
  firefox https://cryptpad.ds &; disown
  watch docker stack ps cryptpad
}

ds.cryptpad-kill() {
  docker stack rm cryptpad
  sleep 6
  docker volume prune
}

# directus
ds.directus() {
  ds-net-traefik
  DOMAIN=directus.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/directus.yml directus
  firefox https://directus.ds &; disown
  watch docker stack ps directus
}

ds.directus-kill() {
  docker stack rm directus
  sleep 6
  docker volume prune
}

# discourse
ds.discourse() {
  ds-net-traefik
  DOMAIN=discourse.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/discourse.yml discourse
  firefox https://discourse.ds &; disown
  watch docker stack ps discourse
}

ds.discourse-kill() {
  docker stack rm discourse
  sleep 6
  docker volume prune
}

# dolibarr
ds.dolibarr() {
  ds-net-traefik
  DOMAIN=dolibarr.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/dolibarr.yml dolibarr
  firefox https://dolibarr.ds &; disown
  watch docker stack ps dolibarr
}

ds.dolibarr-kill() {
  docker stack rm dolibarr
  sleep 6
  docker volume prune
}

# drawio
ds.drawio() {
  ds-net-traefik
  DOMAIN=drawio.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/drawio.yml drawio
  firefox https://drawio.ds &; disown
  watch docker stack ps drawio
}

ds.drawio-kill() {
  docker stack rm drawio
  sleep 6
  docker volume prune
}

# element
ds.element() {
  ds-net-traefik
  DOMAIN=element.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/element.yml element
  firefox https://element.ds &; disown
  watch docker stack ps element
}

ds.element-kill() {
  docker stack rm element
  sleep 6
  docker volume prune
}

# ethercalc
ds.ethercalc() {
  ds-net-traefik
  DOMAIN=ethercalc.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/ethercalc.yml ethercalc
  firefox https://ethercalc.ds &; disown
  watch docker stack ps ethercalc
}

ds.ethercalc-kill() {
  docker stack rm ethercalc
  sleep 6
  docker volume prune
}

# etherpad
ds.etherpad() {
  ds-net-traefik
  DOMAIN=etherpad.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/etherpad.yml etherpad
  firefox https://etherpad.ds &; disown
  watch docker stack ps etherpad
}

ds.etherpad-kill() {
  docker stack rm etherpad
  sleep 6
  docker volume prune
}

# ethibox
ds.ethibox() {
  ds-net-traefik
  DOMAIN=ethibox.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/ethibox.yml ethibox
  firefox https://ethibox.ds &; disown
  watch docker stack ps ethibox
}

ds.ethibox-kill() {
  docker stack rm ethibox
  sleep 6
  docker volume prune
}

# fathom
ds.fathom() {
  ds-net-traefik
  DOMAIN=fathom.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/fathom.yml fathom
  firefox https://fathom.ds &; disown
  watch docker stack ps fathom
}

ds.fathom-kill() {
  docker stack rm fathom
  sleep 6
  docker volume prune
}

# firefly
ds.firefly() {
  ds-net-traefik
  DOMAIN=firefly.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/firefly.yml firefly
  firefox https://firefly.ds &; disown
  watch docker stack ps firefly
}

ds.firefly-kill() {
  docker stack rm firefly
  sleep 6
  docker volume prune
}

# flarum
ds.flarum() {
  ds-net-traefik
  DOMAIN=flarum.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/flarum.yml flarum
  firefox https://flarum.ds &; disown
  watch docker stack ps flarum
}

ds.flarum-kill() {
  docker stack rm flarum
  sleep 6
  docker volume prune
}

# framadate
ds.framadate() {
  ds-net-traefik
  DOMAIN=framadate.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/framadate.yml framadate
  firefox https://framadate.ds &; disown
  watch docker stack ps framadate
}

ds.framadate-kill() {
  docker stack rm framadate
  sleep 6
  docker volume prune
}

# freshrss
ds.freshrss() {
  ds-net-traefik
  DOMAIN=freshrss.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/freshrss.yml freshrss
  firefox https://freshrss.ds &; disown
  watch docker stack ps freshrss
}

ds.freshrss-kill() {
  docker stack rm freshrss
  sleep 6
  docker volume prune
}

# ghost
ds.ghost() {
  ds-net-traefik
  DOMAIN=ghost.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/ghost.yml ghost
  firefox https://ghost.ds &; disown
  watch docker stack ps ghost
}

ds.ghost-kill() {
  docker stack rm ghost
  sleep 6
  docker volume prune
}

# gitlab
ds.gitlab() {
  ds-net-traefik
  DOMAIN=gitlab.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/gitlab.yml gitlab
  firefox https://gitlab.ds &; disown
  watch docker stack ps gitlab
}

ds.gitlab-kill() {
  docker stack rm gitlab
  sleep 6
  docker volume prune
}

# gogs
ds.gogs() {
  ds-net-traefik
  DOMAIN=gogs.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/gogs.yml gogs
  firefox https://gogs.ds &; disown
  watch docker stack ps gogs
}

ds.gogs-kill() {
  docker stack rm gogs
  sleep 6
  docker volume prune
}

# grafana
ds.grafana() {
  ds-net-traefik
  DOMAIN=grafana.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/grafana.yml grafana
  firefox https://grafana.ds &; disown
  watch docker stack ps grafana
}

ds.grafana-kill() {
  docker stack rm grafana
  sleep 6
  docker volume prune
}

# grav
ds.grav() {
  ds-net-traefik
  DOMAIN=grav.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/grav.yml grav
  firefox https://grav.ds &; disown
  watch docker stack ps grav
}

ds.grav-kill() {
  docker stack rm grav
  sleep 6
  docker volume prune
}

# habitica
ds.habitica() {
  ds-net-traefik
  DOMAIN=habitica.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/habitica.yml habitica
  firefox https://habitica.ds &; disown
  watch docker stack ps habitica
}

ds.habitica-kill() {
  docker stack rm habitica
  sleep 6
  docker volume prune
}

# hasura
ds.hasura() {
  ds-net-traefik
  DOMAIN=hasura.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/hasura.yml hasura
  firefox https://hasura.ds &; disown
  watch docker stack ps hasura
}

ds.hasura-kill() {
  docker stack rm hasura
  sleep 6
  docker volume prune
}

# hedgedoc
ds.hedgedoc() {
  ds-net-traefik
  DOMAIN=hedgedoc.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/hedgedoc.yml hedgedoc
  firefox https://hedgedoc.ds &; disown
  watch docker stack ps hedgedoc
}

ds.hedgedoc-kill() {
  docker stack rm hedgedoc
  sleep 6
  docker volume prune
}

# huginn
ds.huginn() {
  ds-net-traefik
  DOMAIN=huginn.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/huginn.yml huginn
  firefox https://huginn.ds &; disown
  watch docker stack ps huginn
}

ds.huginn-kill() {
  docker stack rm huginn
  sleep 6
  docker volume prune
}

# invoiceninja
ds.invoiceninja() {
  ds-net-traefik
  DOMAIN=invoiceninja.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/invoiceninja.yml invoiceninja
  firefox https://invoiceninja.ds &; disown
  watch docker stack ps invoiceninja
}

ds.invoiceninja-kill() {
  docker stack rm invoiceninja
  sleep 6
  docker volume prune
}

# jenkins
ds.jenkins() {
  ds-net-traefik
  DOMAIN=jenkins.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/jenkins.yml jenkins
  firefox https://jenkins.ds &; disown
  watch docker stack ps jenkins
}

ds.jenkins-kill() {
  docker stack rm jenkins
  sleep 6
  docker volume prune
}

# jitsi
ds.jitsi() {
  ds-net-traefik
  DOMAIN=jitsi.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/jitsi.yml jitsi
  firefox https://jitsi.ds &; disown
  watch docker stack ps jitsi
}

ds.jitsi-kill() {
  docker stack rm jitsi
  sleep 6
  docker volume prune
}

# kanboard
ds.kanboard() {
  ds-net-traefik
  DOMAIN=kanboard.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/kanboard.yml kanboard
  firefox https://kanboard.ds &; disown
  watch docker stack ps kanboard
}

ds.kanboard-kill() {
  docker stack rm kanboard
  sleep 6
  docker volume prune
}

# listmonk
ds.listmonk() {
  ds-net-traefik
  DOMAIN=listmonk.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/listmonk.yml listmonk
  firefox https://listmonk.ds &; disown
  watch docker stack ps listmonk
}

ds.listmonk-kill() {
  docker stack rm listmonk
  sleep 6
  docker volume prune
}

# magento
ds.magento() {
  ds-net-traefik
  DOMAIN=magento.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/magento.yml magento
  firefox https://magento.ds &; disown
  watch docker stack ps magento
}

ds.magento-kill() {
  docker stack rm magento
  sleep 6
  docker volume prune
}

# mailserver
ds.mailserver() {
  ds-net-traefik
  DOMAIN=mailserver.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/mailserver.yml mailserver
  firefox https://mailserver.ds &; disown
  watch docker stack ps mailserver
}

ds.mailserver-kill() {
  docker stack rm mailserver
  sleep 6
  docker volume prune
}

# mailtrain
ds.mailtrain() {
  ds-net-traefik
  DOMAIN=mailtrain.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/mailtrain.yml mailtrain
  firefox https://mailtrain.ds &; disown
  watch docker stack ps mailtrain
}

ds.mailtrain-kill() {
  docker stack rm mailtrain
  sleep 6
  docker volume prune
}

# mastodon
ds.mastodon() {
  ds-net-traefik
  DOMAIN=mastodon.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/mastodon.yml mastodon
  firefox https://mastodon.ds &; disown
  watch docker stack ps mastodon
}

ds.mastodon-kill() {
  docker stack rm mastodon
  sleep 6
  docker volume prune
}

# matomo
ds.matomo() {
  ds-net-traefik
  DOMAIN=matomo.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/matomo.yml matomo
  firefox https://matomo.ds &; disown
  watch docker stack ps matomo
}

ds.matomo-kill() {
  docker stack rm matomo
  sleep 6
  docker volume prune
}

# mattermost
ds.mattermost() {
  ds-net-traefik
  DOMAIN=mattermost.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/mattermost.yml mattermost
  firefox https://mattermost.ds &; disown
  watch docker stack ps mattermost
}

ds.mattermost-kill() {
  docker stack rm mattermost
  sleep 6
  docker volume prune
}

# matterwiki
ds.matterwiki() {
  ds-net-traefik
  DOMAIN=matterwiki.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/matterwiki.yml matterwiki
  firefox https://matterwiki.ds &; disown
  watch docker stack ps matterwiki
}

ds.matterwiki-kill() {
  docker stack rm matterwiki
  sleep 6
  docker volume prune
}

# mautic
ds.mautic() {
  ds-net-traefik
  DOMAIN=mautic.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/mautic.yml mautic
  firefox https://mautic.ds &; disown
  watch docker stack ps mautic
}

ds.mautic-kill() {
  docker stack rm mautic
  sleep 6
  docker volume prune
}

# mediawiki
ds.mediawiki() {
  ds-net-traefik
  DOMAIN=mediawiki.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/mediawiki.yml mediawiki
  firefox https://mediawiki.ds &; disown
  watch docker stack ps mediawiki
}

ds.mediawiki-kill() {
  docker stack rm mediawiki
  sleep 6
  docker volume prune
}

# metabase
ds.metabase() {
  ds-net-traefik
  DOMAIN=metabase.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/metabase.yml metabase
  firefox https://metabase.ds &; disown
  watch docker stack ps metabase
}

ds.metabase-kill() {
  docker stack rm metabase
  sleep 6
  docker volume prune
}

# minio
ds.minio() {
  ds-net-traefik
  DOMAIN=minio.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/minio.yml minio
  firefox https://minio.ds &; disown
  watch docker stack ps minio
}

ds.minio-kill() {
  docker stack rm minio
  sleep 6
  docker volume prune
}

# mobilizon
ds.mobilizon() {
  ds-net-traefik
  DOMAIN=mobilizon.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/mobilizon.yml mobilizon
  firefox https://mobilizon.ds &; disown
  watch docker stack ps mobilizon
}

ds.mobilizon-kill() {
  docker stack rm mobilizon
  sleep 6
  docker volume prune
}

# monitoring
ds.monitoring() {
  ds-net-traefik
  DOMAIN=monitoring.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/monitoring.yml monitoring
  firefox https://monitoring.ds &; disown
  watch docker stack ps monitoring
}

ds.monitoring-kill() {
  docker stack rm monitoring
  sleep 6
  docker volume prune
}

# n8n
ds.n8n() {
  ds-net-traefik
  DOMAIN=n8n.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/n8n.yml n8n
  firefox https://n8n.ds &; disown
  watch docker stack ps n8n
}

ds.n8n-kill() {
  docker stack rm n8n
  sleep 6
  docker volume prune
}

# nextcloud
ds.nextcloud() {
  ds-net-traefik
  DOMAIN=nextcloud.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/nextcloud.yml nextcloud
  firefox https://nextcloud.ds &; disown
  watch docker stack ps nextcloud
}

ds.nextcloud-kill() {
  docker stack rm nextcloud
  sleep 6
  docker volume prune
}

# nitter
ds.nitter() {
  ds-net-traefik
  DOMAIN=nitter.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/nitter.yml nitter
  firefox https://nitter.ds &; disown
  watch docker stack ps nitter
}

ds.nitter-kill() {
  docker stack rm nitter
  sleep 6
  docker volume prune
}

# nocodb
ds.nocodb() {
  ds-net-traefik
  DOMAIN=nocodb.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/nocodb.yml nocodb
  firefox https://nocodb.ds &; disown
  watch docker stack ps nocodb
}

ds.nocodb-kill() {
  docker stack rm nocodb
  sleep 6
  docker volume prune
}

# odoo
ds.odoo() {
  ds-net-traefik
  DOMAIN=odoo.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/odoo.yml odoo
  firefox https://odoo.ds &; disown
  watch docker stack ps odoo
}

ds.odoo-kill() {
  docker stack rm odoo
  sleep 6
  docker volume prune
}

# passbolt
ds.passbolt() {
  ds-net-traefik
  DOMAIN=passbolt.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/passbolt.yml passbolt
  firefox https://passbolt.ds &; disown
  watch docker stack ps passbolt
}

ds.passbolt-kill() {
  docker stack rm passbolt
  sleep 6
  docker volume prune
}

# peertube
ds.peertube() {
  ds-net-traefik
  DOMAIN=peertube.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/peertube.yml peertube
  firefox https://peertube.ds &; disown
  watch docker stack ps peertube
}

ds.peertube-kill() {
  docker stack rm peertube
  sleep 6
  docker volume prune
}

# phpbb
ds.phpbb() {
  ds-net-traefik
  DOMAIN=phpbb.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/phpbb.yml phpbb
  firefox https://phpbb.ds &; disown
  watch docker stack ps phpbb
}

ds.phpbb-kill() {
  docker stack rm phpbb
  sleep 6
  docker volume prune
}

# pinafore
ds.pinafore() {
  ds-net-traefik
  DOMAIN=pinafore.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/pinafore.yml pinafore
  firefox https://pinafore.ds &; disown
  watch docker stack ps pinafore
}

ds.pinafore-kill() {
  docker stack rm pinafore
  sleep 6
  docker volume prune
}

# pixelfed
ds.pixelfed() {
  ds-net-traefik
  DOMAIN=pixelfed.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/pixelfed.yml pixelfed
  firefox https://pixelfed.ds &; disown
  watch docker stack ps pixelfed
}

ds.pixelfed-kill() {
  docker stack rm pixelfed
  sleep 6
  docker volume prune
}

# plume
ds.plume() {
  ds-net-traefik
  DOMAIN=plume.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/plume.yml plume
  firefox https://plume.ds &; disown
  watch docker stack ps plume
}

ds.plume-kill() {
  docker stack rm plume
  sleep 6
  docker volume prune
}

# polr
ds.polr() {
  ds-net-traefik
  DOMAIN=polr.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/polr.yml polr
  firefox https://polr.ds &; disown
  watch docker stack ps polr
}

ds.polr-kill() {
  docker stack rm polr
  sleep 6
  docker volume prune
}

# portainer
ds.portainer() {
  ds-net-traefik
  DOMAIN=portainer.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/portainer.yml portainer
  firefox https://portainer.ds &; disown
  watch docker stack ps portainer
}

ds.portainer-kill() {
  docker stack rm portainer
  sleep 6
  docker volume prune
}

# posthog
ds.posthog() {
  ds-net-traefik
  DOMAIN=posthog.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/posthog.yml posthog
  firefox https://posthog.ds &; disown
  watch docker stack ps posthog
}

ds.posthog-kill() {
  docker stack rm posthog
  sleep 6
  docker volume prune
}

# prestashop
ds.prestashop() {
  ds-net-traefik
  DOMAIN=prestashop.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/prestashop.yml prestashop
  firefox https://prestashop.ds &; disown
  watch docker stack ps prestashop
}

ds.prestashop-kill() {
  docker stack rm prestashop
  sleep 6
  docker volume prune
}

# pydio
ds.pydio() {
  ds-net-traefik
  DOMAIN=pydio.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/pydio.yml pydio
  firefox https://pydio.ds &; disown
  watch docker stack ps pydio
}

ds.pydio-kill() {
  docker stack rm pydio
  sleep 6
  docker volume prune
}

# pytition
ds.pytition() {
  ds-net-traefik
  DOMAIN=pytition.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/pytition.yml pytition
  firefox https://pytition.ds &; disown
  watch docker stack ps pytition
}

ds.pytition-kill() {
  docker stack rm pytition
  sleep 6
  docker volume prune
}

# rainloop
ds.rainloop() {
  ds-net-traefik
  DOMAIN=rainloop.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/rainloop.yml rainloop
  firefox https://rainloop.ds &; disown
  watch docker stack ps rainloop
}

ds.rainloop-kill() {
  docker stack rm rainloop
  sleep 6
  docker volume prune
}

# redmine
ds.redmine() {
  ds-net-traefik
  DOMAIN=redmine.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/redmine.yml redmine
  firefox https://redmine.ds &; disown
  watch docker stack ps redmine
}

ds.redmine-kill() {
  docker stack rm redmine
  sleep 6
  docker volume prune
}

# registry
ds.registry() {
  ds-net-traefik
  DOMAIN=registry.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/registry.yml registry
  firefox https://registry.ds &; disown
  watch docker stack ps registry
}

ds.registry-kill() {
  docker stack rm registry
  sleep 6
  docker volume prune
}

# rocketchat
ds.rocketchat() {
  ds-net-traefik
  DOMAIN=rocketchat.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/rocketchat.yml rocketchat
  firefox https://rocketchat.ds &; disown
  watch docker stack ps rocketchat
}

ds.rocketchat-kill() {
  docker stack rm rocketchat
  sleep 6
  docker volume prune
}

# rsshub
ds.rsshub() {
  ds-net-traefik
  DOMAIN=rsshub.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/rsshub.yml rsshub
  firefox https://rsshub.ds &; disown
  watch docker stack ps rsshub
}

ds.rsshub-kill() {
  docker stack rm rsshub
  sleep 6
  docker volume prune
}

# scrumblr
ds.scrumblr() {
  ds-net-traefik
  DOMAIN=scrumblr.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/scrumblr.yml scrumblr
  firefox https://scrumblr.ds &; disown
  watch docker stack ps scrumblr
}

ds.scrumblr-kill() {
  docker stack rm scrumblr
  sleep 6
  docker volume prune
}

# searx
ds.searx() {
  ds-net-traefik
  DOMAIN=searx.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/searx.yml searx
  firefox https://searx.ds &; disown
  watch docker stack ps searx
}

ds.searx-kill() {
  docker stack rm searx
  sleep 6
  docker volume prune
}

# suitecrm
ds.suitecrm() {
  ds-net-traefik
  DOMAIN=suitecrm.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/suitecrm.yml suitecrm
  firefox https://suitecrm.ds &; disown
  watch docker stack ps suitecrm
}

ds.suitecrm-kill() {
  docker stack rm suitecrm
  sleep 6
  docker volume prune
}

# taiga
ds.taiga() {
  ds-net-traefik
  DOMAIN=taiga.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/taiga.yml taiga
  firefox https://taiga.ds &; disown
  watch docker stack ps taiga
}

ds.taiga-kill() {
  docker stack rm taiga
  sleep 6
  docker volume prune
}

# talk
ds.talk() {
  ds-net-traefik
  DOMAIN=talk.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/talk.yml talk
  firefox https://talk.ds &; disown
  watch docker stack ps talk
}

ds.talk-kill() {
  docker stack rm talk
  sleep 6
  docker volume prune
}

# traefik
ds.traefik() {
  ds-net-traefik
  DOMAIN=traefik.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/traefik.yml traefik
  firefox https://traefik.ds &; disown
  watch docker stack ps traefik
}

ds.traefik-kill() {
  docker stack rm traefik
  sleep 6
  docker volume prune
}

# umami
ds.umami() {
  ds-net-traefik
  DOMAIN=umami.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/umami.yml umami
  firefox https://umami.ds &; disown
  watch docker stack ps umami
}

ds.umami-kill() {
  docker stack rm umami
  sleep 6
  docker volume prune
}

# uptime-kuma
ds.uptime-kuma() {
  ds-net-traefik
  DOMAIN=uptime-kuma.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/uptime-kuma.yml uptime-kuma
  firefox https://uptime-kuma.ds &; disown
  watch docker stack ps uptime-kuma
}

ds.uptime-kuma-kill() {
  docker stack rm uptime-kuma
  sleep 6
  docker volume prune
}

# waiting
ds.waiting() {
  ds-net-traefik
  DOMAIN=waiting.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/waiting.yml waiting
  firefox https://waiting.ds &; disown
  watch docker stack ps waiting
}

ds.waiting-kill() {
  docker stack rm waiting
  sleep 6
  docker volume prune
}

# wallabag
ds.wallabag() {
  ds-net-traefik
  DOMAIN=wallabag.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/wallabag.yml wallabag
  firefox https://wallabag.ds &; disown
  watch docker stack ps wallabag
}

ds.wallabag-kill() {
  docker stack rm wallabag
  sleep 6
  docker volume prune
}

# wekan
ds.wekan() {
  ds-net-traefik
  DOMAIN=wekan.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/wekan.yml wekan
  firefox https://wekan.ds &; disown
  watch docker stack ps wekan
}

ds.wekan-kill() {
  docker stack rm wekan
  sleep 6
  docker volume prune
}

# whoogle-search
ds.whoogle-search() {
  ds-net-traefik
  DOMAIN=whoogle-search.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/whoogle-search.yml whoogle-search
  firefox https://whoogle-search.ds &; disown
  watch docker stack ps whoogle-search
}

ds.whoogle-search-kill() {
  docker stack rm whoogle-search
  sleep 6
  docker volume prune
}

# wikijs
ds.wikijs() {
  ds-net-traefik
  DOMAIN=wikijs.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/wikijs.yml wikijs
  firefox https://wikijs.ds &; disown
  watch docker stack ps wikijs
}

ds.wikijs-kill() {
  docker stack rm wikijs
  sleep 6
  docker volume prune
}

# wordpress
ds.wordpress() {
  ds-net-traefik
  DOMAIN=wordpress.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/wordpress.yml wordpress
  firefox https://wordpress.ds &; disown
  watch docker stack ps wordpress
}

ds.wordpress-kill() {
  docker stack rm wordpress
  sleep 6
  docker volume prune
}

# writefreely
ds.writefreely() {
  ds-net-traefik
  DOMAIN=writefreely.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/writefreely.yml writefreely
  firefox https://writefreely.ds &; disown
  watch docker stack ps writefreely
}

ds.writefreely-kill() {
  docker stack rm writefreely
  sleep 6
  docker volume prune
}

# zammad
ds.zammad() {
  ds-net-traefik
  DOMAIN=zammad.ds docker stack deploy -c ${HOME}/git/misc/awesome-stacks/stacks/zammad.yml zammad
  firefox https://zammad.ds &; disown
  watch docker stack ps zammad
}

ds.zammad-kill() {
  docker stack rm zammad
  sleep 6
  docker volume prune
}

eval "$(mcfly init zsh)"

ntd() {
  UUID=`uuidgen | choose -f '-' 0`
  mkdir ${UUID}
  cd ${UUID}
  pwd
}

jt() {
  # Allow call from terminal
  if [[ "$#" == 1 ]]; then
      TICKET_ID=$1
  else
      TICKET_ID=`pwd | choose -f '/' -1`
      TICKET_VALID=`echo $TICKET_ID | grep -E "^[a-zA-Z]{1,16}-[0-9]{1,}$"`

      if [[ "$TICKET_VALID" == "" ]]; then
          echo "Error: Couldn't find valid ticket ID. Are you in ticket directory?"
          return 1
      fi
  fi

  grep "Ticket URL" ./${TICKET_ID}.md | choose -1
  echo
  echo -n "Title: "
  head -1 ./${TICKET_ID}.md | choose -f "## " -1
  echo
  echo "Status:"
  echo "$(awk '/Status/{flag=1; next} /Plan/{flag=0} flag' ./${TICKET_ID}.md)" | sed 's/\t-/ -/g'
  echo

  echo "Tasks:"

  grep -E "DONE" ./${TICKET_ID}.md | choose -f '- ' -1 > ./tasks_tmp.txt
  grep -E "TODO" ./${TICKET_ID}.md | choose -f '- ' -1 >> ./tasks_tmp.txt
  grep -E "DOING" ./${TICKET_ID}.md | choose -f '- ' -1 >> ./tasks_tmp.txt

  sed -i 's/DONE/\\033[1;32mDONE\\033[0m/g' ./tasks_tmp.txt
  sed -i 's/TODO/\\033[0;31mTODO\\033[0m/g' ./tasks_tmp.txt
  sed -i 's/DOING/\\033[1;33mDOING\\033[0m/g' ./tasks_tmp.txt
  TASKS_TMP=$(cat ./tasks_tmp.txt)
  echo $TASKS_TMP
  rm ./tasks_tmp.txt
}

jira_last_ticket() {
  DATE_YEAR=`date +%Y`
  DATE_MONTH=`date +%m`
  DATE_DAY=`date +%d`
  DATE_HOUR=`date +%H`
  DATE_MINUTE=`date +%M`

  LOGSEQ_DIRECTORY="${HOME}/Data/logseq"
  TICKET_BASE_DIRECTORY="${HOME}/work/jobs/"

  LAST_TICKET_DIRECTORY=`find -L ${TICKET_BASE_DIRECTORY} -maxdepth 3 ! -type d -printf "%T+ %p\n" | sort | tail -1 | choose 1 | sed 's:[^/]*$::'`
  LAST_TICKET_ID=`echo -n ${LAST_TICKET_DIRECTORY} | choose -f '/' -1`

  cd $LAST_TICKET_DIRECTORY

  # Link in current directory
  ln -s ${LOGSEQ_DIRECTORY}/pages/${LAST_TICKET_ID}.md ./${LAST_TICKET_ID}.md 2>/dev/null

  # Update ticket_current
  rm ${HOME}/ticket_current
  ln -sf $LAST_TICKET_DIRECTORY ${HOME}/ticket_current

  # Don't prepend ticket if it already is the first line in journal
  TICKET_PREPENDED=`head -1 ${LOGSEQ_DIRECTORY}/journals/${DATE_YEAR}_${DATE_MONTH}_${DATE_DAY}.md | grep $LAST_TICKET_ID | wc -l`

  TICKET_TITLE=`head -1 ${LOGSEQ_DIRECTORY}/pages/${LAST_TICKET_ID}.md | choose -f "## " 0`

  if [[ "$TICKET_PREPENDED" != "1" ]]; then
    echo -e "- **${DATE_HOUR}:${DATE_MINUTE}** #${LAST_TICKET_ID} ${TICKET_TITLE}\n$(cat ${LOGSEQ_DIRECTORY}/journals/${DATE_YEAR}_${DATE_MONTH}_${DATE_DAY}.md)" > ${LOGSEQ_DIRECTORY}/journals/${DATE_YEAR}_${DATE_MONTH}_${DATE_DAY}.md
  fi

  pwd
  echo
  exa --long --all --header --icons --git
  echo

  jt ${LAST_TICKET_ID}
}

jira_ticket() {
  DATE_YEAR=`date +%Y`
  DATE_MONTH=`date +%m`
  DATE_DAY=`date +%d`

  LOGSEQ_DIRECTORY="${HOME}/Data/logseq"
  TICKET_BASE_DIRECTORY="${HOME}/work/jobs/"
  TICKET_LIST=""
  TICKET_TITLE=""

  # If ticket ID hasn't been specified to function
  if [[ $# != 2 ]]; then
    while IFS= read -r output; do
      TICKET_TITLE=`head -1 $output | choose -f "## " 0`
      TICKET_URL=`head -2 $output | grep "Ticket URL" | choose -1`
      TICKET_ID=`echo -n $TICKET_URL | choose -f '/' -1`
      TICKET_LIST="${TICKET_LIST}\n${TICKET_ID} ${TICKET_URL} ${TICKET_TITLE}"
    done < <(find "$TICKET_BASE_DIRECTORY" -maxdepth 3 -type l -name "*.md" -printf "%T+ %p\n" | sort | choose 1)

    TICKET=`printf "%b" "$TICKET_LIST" | fzf --prompt "Specify existing ticket: " | choose 0`
  else
    TICKET=$1
    TICKET_TITLE=$2
  fi

  # trap ctrl-c and call ctrl_c()
  trap ctrl_c INT

  function ctrl_c() {
    echo
    echo "Exiting.."
    sleep 1
    exit 1
  }

  TICKET_IS_URL=`echo $TICKET | grep "http" | wc -l`

  if [[ "$TICKET_IS_URL" == "1" ]]; then
    TICKET_URL=$TICKET
    TICKET_ID=`echo "$TICKET_URL" | choose -f '/' -1 | choose -f '\?|#' 0`
  else
    TICKET_BASE_URL=`cat /etc/jira`
    TICKET_ID=$TICKET
    TICKET_URL="${TICKET_BASE_URL}/browse/${TICKET_ID}"
  fi

  # Validate ticket ID
  TICKET_VALID=`echo $TICKET_ID | grep -E "^[a-zA-Z]{1,16}-[0-9]{1,}$"`
  if [[ "$TICKET_VALID" == "" ]]; then
    echo "Error: Ticket ID not valid"
    return 1
  fi

  DATE_HOUR=`date +%H`
  DATE_MINUTE=`date +%M`
  TICKET_DIRECTORY="${HOME}/work/jobs/${DATE_YEAR}/${TICKET_ID}/"

  mkdir -p $TICKET_DIRECTORY
  cd $TICKET_DIRECTORY

  if [[ ! -f "${LOGSEQ_DIRECTORY}/pages/${TICKET_ID}.md" ]]; then
    if [[ "$TICKET_TITLE" == "" ]]; then
      echo -n "Title > "
      read TICKET_TITLE
    fi

    echo "## $TICKET_TITLE
- **Ticket URL** ${TICKET_URL}
- **Problem statement**
        -
- **Acceptance criteria**
        -
- **Outcome**
        -
- **Status**
        -
- **Plan**
        -
- **Notes**
        -
- **Questions**
        -
- **Opportunities**
        -
- **Risks**
        -
- **Contact(s)**
        -
- **Resources**
        -" > ${LOGSEQ_DIRECTORY}/pages/${TICKET_ID}.md
  fi

  # Link in current directory
  ln -s ${LOGSEQ_DIRECTORY}/pages/${TICKET_ID}.md ./${TICKET_ID}.md 2>/dev/null
  touch ./${TICKET_ID}.md

  # Don't prepend ticket if it already is the first line in journal
  TICKET_PREPENDED=`head -1 ${LOGSEQ_DIRECTORY}/journals/${DATE_YEAR}_${DATE_MONTH}_${DATE_DAY}.md | grep $TICKET_ID | wc -l`

  TICKET_TITLE=`head -1 ${LOGSEQ_DIRECTORY}/pages/${TICKET_ID}.md | choose -f "## " 0`

  if [[ "$TICKET_PREPENDED" != "1" ]]; then
    echo -e "- **${DATE_HOUR}:${DATE_MINUTE}** #${TICKET_ID} ${TICKET_TITLE}\n$(cat ${LOGSEQ_DIRECTORY}/journals/${DATE_YEAR}_${DATE_MONTH}_${DATE_DAY}.md)" > ${LOGSEQ_DIRECTORY}/journals/${DATE_YEAR}_${DATE_MONTH}_${DATE_DAY}.md
  fi

  pwd
  exa --long --all --header --icons --git
  jt ${TICKET_ID}
}

cpd() {
  LAST_DOWNLOAD=`ls -tr ${HOME}/Downloads | tail -1`
  #tmp_work
  cp -rf "${HOME}/Downloads/${LAST_DOWNLOAD}" .
  pwd
  exa --long --all --header --icons --git
}

cdf() {
  cd "$1"
  exa --long --all --header --icons --git | fzf
}

tmp_work() {
  DATE_YEAR=`date +%Y`
  DATE_MONTH=`date +%m`
  DATE_DAY=`date +%d`
  TMP_DIRECTORY="$HOME/work/tmp/${DATE_YEAR}/${DATE_MONTH}/${DATE_DAY}/"

  mkdir -p $TMP_DIRECTORY
  cd $TMP_DIRECTORY
}

new_calendar_event() {
  /home/user/git/maxos/scripts/new_calendar_event.sh
}

if [[ ! -z "${REMOTEWORK}" ]]; then
  ssh user@alm.gg
fi

if [[ ! -z "${TMPWORK}" ]]; then
  tmp_work
  pwd
  exa --long --all --header --icons --git
fi

if [[ ! -z "${NEW_CALENDAR_EVENT}" ]]; then
  new_calendar_event
fi

if [[ ! -z "${JIRA_CLI}" ]]; then
  cd /home/user/git/github/jira-cli
  source .venv/bin/activate

  ./main.py
fi

if [[ ! -z "${JIRA_NEW}" ]]; then
  echo -n "New Jira ticket title > "
  read JIRA_DESIRED_TITLE

  echo -n "Private ticket ID? (Blank if syncing) > "
  read PRIVATE_TICKET_ID

  # Check if the answer is "yes" or "y"
  if [[ "$PRIVATE_TICKET_ID" == "" ]]; then
    JIRA_TICKET_INFO=$(docker run --rm -it --entrypoint /root/jira_new.py -v "/home/user/git/jira_sync/config:/config" jira-sync --ticket-title "$JIRA_DESIRED_TITLE")
  else
    JIRA_TICKET_INFO=$(docker run --rm -it --entrypoint /root/jira_new.py -v "/home/user/git/jira_sync/config:/config" jira-sync --ticket-title "$JIRA_DESIRED_TITLE" --ticket-private "$PRIVATE_TICKET_ID")
  fi

  JIRA_TICKET_TITLE=$(echo $JIRA_TICKET_INFO | head -1)
  JIRA_TICKET_ID=$(echo $JIRA_TICKET_INFO | tail -1 | sed 's/\r//g')

  jira_ticket $JIRA_TICKET_ID "$JIRA_TICKET_TITLE"
fi

if [[ ! -z "${JIRATICKET}" ]]; then
  jira_ticket
fi

if [[ ! -z "${JIRALASTTICKET}" ]]; then
  jira_last_ticket
fi

if [[ ! -z "${WEBSCAN}" ]]; then
  tmp_work
  cp /home/user/git/maxos/scripts/webscan.sh $TMP_DIRECTORY
  cp /home/user/git/maxos/resources/targets.txt $TMP_DIRECTORY
  vim targets.txt
fi

if [[ ! -z "${OLLAMA_LLAMA2}" ]]; then
  CONTAINER_ID=`docker ps --format "{{.ID}}" -f name="ollama$"`
  if [[ "$CONTAINER_ID" != "" ]]; then
    /run/current-system/sw/bin/docker exec -it $CONTAINER_ID /bin/bash -c 'ollama run llama2:13b'
    cd
  else
    echo "ERROR: Could not find running ollama container"
  fi
fi

if [[ ! -z "${OLLAMA_MISTRAL}" ]]; then
  CONTAINER_ID=`docker ps --format "{{.ID}}" -f name="ollama$"`
  if [[ "$CONTAINER_ID" != "" ]]; then
    /run/current-system/sw/bin/docker exec -it $CONTAINER_ID /bin/bash -c 'ollama run mistral:7b'
    cd
  else
    echo "ERROR: Could not find running ollama container"
  fi
fi

if [[ ! -z "${NOHISTFILE}" ]]; then
  tmp_work
  pwd
  exa --long --all --header --icons --git
  fc -p
fi

case "$DO_TASK" in
    fs-git-maxos)
        cd /home/user/git/maxos-next
        pwd
        exa --long --all --header --icons --git
    ;;
    fs-home-downloads)
        cd /home/user/Downloads
        pwd
        exa --long --all --header --icons --git
    ;;
    fs-home-data)
        cd /home/user/Data
        pwd
        exa --long --all --header --icons --git
    ;;
    cmd-docker-ps-a)
        docker ps -a | tail -n +2 | fzf
    ;;
    cmd-docker-inspect)
        DOCKER_IMAGE_ID=`docker ps -a | tail -n +2 | fzf | choose 0`
        docker inspect $DOCKER_IMAGE_ID | jq
        echo $DOCKER_IMAGE_ID
    ;;
    cmd-docker-kill)
        docker kill $(docker ps -a | tail -n +2 | fzf | choose 0)
    ;;
    cmd-docker-navigate)
        IP_PORT=`docker port "$(docker ps -a | tail -n +2 | fzf | choose 0)" | choose -1`
        if [[ $(echo "$IP_PORT" | wc -l) == 1 ]]; then
            xdg-open http://${IP_PORT}
            sleep 1
            i3-msg "[title=\"Firefox\"] focus"
            exit 0
        else
            echo
            echo "ERROR: Docker container has multiple exposed ports"
            echo
            echo $IP_PORT
        fi
    ;;
    cmd-ticker)
        ticker --show-fundamentals --show-holdings --show-summary --show-tags -w AAPL,NET
        exit 0
    ;;
esac

preexec() {
   (( $#_elapsed > 1000 )) && set -A _elapsed $_elapsed[-1000,-1]
   typeset -ig _start=SECONDS
}

precmd() {
    EXIT_STATUS=$?
    set -A _elapsed $_elapsed $(( SECONDS-_start ))
    if (( $_elapsed[-1] > 10 )) && [[ "$(xdotool getwindowfocus)" -ne "$WINDOWID" ]]; then
        if (( $EXIT_STATUS == 0 )); then
            aplay -q /home/user/git/maxos/resources/sounds/mixkit-correct-answer-tone-2870.wav
        else
            aplay -q /home/user/git/maxos/resources/sounds/mixkit-wrong-answer-fail-notification-946.wav
        fi
    fi
}

# appwrite.ds bibliogram.ds bookstack.ds botpress.ds calibre.ds chatwoot.ds commento.ds crater.ds cryptpad.ds directus.ds discourse.ds dolibarr.ds drawio.ds element.ds ethercalc.ds etherpad.ds ethibox.ds fathom.ds firefly.ds flarum.ds framadate.ds freshrss.ds ghost.ds gitlab.ds gogs.ds grafana.ds grav.ds habitica.ds hasura.ds hedgedoc.ds huginn.ds invoiceninja.ds jenkins.ds jitsi.ds kanboard.ds listmonk.ds magento.ds mailserver.ds mailtrain.ds mastodon.ds matomo.ds mattermost.ds matterwiki.ds mautic.ds mediawiki.ds metabase.ds minio.ds mobilizon.ds monitoring.ds n8n.ds nextcloud.ds nitter.ds nocodb.ds odoo.ds passbolt.ds peertube.ds phpbb.ds pinafore.ds pixelfed.ds plume.ds polr.ds portainer.ds posthog.ds prestashop.ds pydio.ds pytition.ds rainloop.ds redmine.ds registry.ds rocketchat.ds rsshub.ds scrumblr.ds searx.ds suitecrm.ds taiga.ds talk.ds traefik.ds umami.ds uptime-kuma.ds waiting.ds wallabag.ds wekan.ds whoogle-search.ds wikijs.ds wordpress.ds writefreely.ds zammad.ds
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
