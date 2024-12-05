# Wait a little
sleep 3

# Update Firefox screenshots and tmp directory bookmark to today
#rm /home/user/screenshots_today
#rm /home/user/tmp_today

#D_YEAR=`date "+%Y"`
#D_MONTH=`date "+%m"`
#D_DAY=`date "+%d"`

#mkdir -p /home/user/screenshots/${D_YEAR}/${D_MONTH}/${D_DAY}/
#mkdir -p /home/user/work/tmp/${D_YEAR}/${D_MONTH}/${D_DAY}/

#ln -sf /home/user/screenshots/${D_YEAR}/${D_MONTH}/${D_DAY}/ /home/user/screenshots_today
#ln -sf /home/user/work/tmp/${D_YEAR}/${D_MONTH}/${D_DAY}/ /home/user/tmp_today

# Clone maxos
#/run/current-system/sw/bin/git clone https://github.com/rascal999/maxos ${HOME}/git/maxos || /run/current-system/sw/bin/git -C ${HOME}/git/maxos pull

# Jupyter templates
mkdir -p ${HOME}/jupyter/pentest/base
rm ${HOME}/jupyter/pentest/base/*.ipynb
rm -rf ${HOME}/jupyter/pentest/base/tools
cp ${HOME}/nixos/resources/jupyter/pentest/*.ipynb ${HOME}/jupyter/pentest/base

# Grafana Strava directory
echo -n "Setting up Grafana directory.."
/run/wrappers/bin/sudo mkdir -p /var/lib/docker/volumes/grafana-data/_data/strava || true
/run/wrappers/bin/sudo chown 472:root /var/lib/docker/volumes/grafana-data/_data/strava -R || true
echo "Done"

# Mullvad VPN
if [[ ! -f /etc/vpn-mullvad ]]; then
  echo "ERROR: Cannot place VPN profiles, could not decrypt?"
  exit 0
fi

# Launch pi-hole
PIHOLE_CHECK=`/run/current-system/sw/bin/docker ps -a -q -f name=pihole | /run/current-system/sw/bin/choose 0`
if [[ "$PIHOLE_CHECK" == "" ]]; then
  /run/current-system/sw/bin/docker-compose -f /home/user/nixos/resources/docker/pi-hole/docker-compose.yml up -d
fi

PLANE_RUNNING=`docker ps -a | grep plane-worker | wc -l`

# Launch plane
if [[ "$PLANE_RUNNING" -eq "0" ]]; then
    echo "Starting plane.."

    cd /home/user/nixos/repos/misc/plane
    chmod +x setup.sh

    # Bug fix
    sed -i 's|#!/bin/bash|#!/usr/bin/env bash|g' setup.sh

    ./setup.sh http://localhost
    set -a
    source /home/user/nixos/repos/misc/plane/.env
    set +a
    docker compose up -d
fi

# Ollama
#cd /home/user/git/maxos/resources/docker/ollama
#docker-compose up -d

# GraphGPT
# Build
#GRAPHGPT_CHECK=`/run/current-system/sw/bin/docker ps -a -q -f name=graphgpt | choose 0`
#if [[ "$GRAPHGPT_CHECK" == "" ]]; then
#  cd /home/user/git/maxos/repos/misc/GraphGPT-docker
#  /run/current-system/sw/bin/docker build -t graphgpt .
#fi

# Run (if secret OpenAI key present)
# TODO

#echo -n "Placing VPN profiles.."
#rm -rf ${HOME}/vpn || true
#/run/current-system/sw/bin/unzip -q /etc/vpn-mullvad -d ${HOME}/vpn || true
#echo "Done"

echo "Launching dunst.."
/run/current-system/sw/bin/pkill dunst
/run/current-system/sw/bin/dunst &
/run/current-system/sw/bin/antimicrox --tray &
