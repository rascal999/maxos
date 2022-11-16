# Clone maxos
/run/current-system/sw/bin/git clone https://github.com/rascal999/maxos ${HOME}/git/maxos || /run/current-system/sw/bin/git -C ${HOME}/git/maxos pull

# Jupyter templates
mkdir -p ${HOME}/jupyter/pentest/base
rm ${HOME}/jupyter/pentest/base/*.ipynb
rm -rf ${HOME}/jupyter/pentest/base/tools
cp ${HOME}/git/maxos/resources/jupyter/pentest/*.ipynb ${HOME}/jupyter/pentest/base

# Grafana Strava directory
echo -n "Setting up Grafana directory.."
sudo mkdir -p /var/lib/docker/volumes/grafana-data/_data/strava || true
sudo chown 472:root /var/lib/docker/volumes/grafana-data/_data/strava -R || true
echo "Done"

# Mullvad VPN
if [[ ! -f /etc/vpn-mullvad ]]; then
  echo "ERROR: Cannot place VPN profiles, could not decrypt?"
  exit 0
fi

# Launch pi-hole
PIHOLE_CHECK=`/run/current-system/sw/bin/docker ps -a -q -f name=pihole | choose 0`
if [[ "$PIHOLE_CHECK" == "" ]]; then
  /run/current-system/sw/bin/docker-compose -f /home/user/git/maxos/resources/docker/pi-hole/docker-compose.yml up -d
fi

echo -n "Placing VPN profiles.."
rm -rf ${HOME}/vpn || true
/run/current-system/sw/bin/tar xf /etc/vpn-mullvad -C ${HOME} || true
echo "Done"
