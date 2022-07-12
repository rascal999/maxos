# Clone nixos
/run/current-system/sw/bin/rm -rf ${HOME}/git/nixos
/run/current-system/sw/bin/git clone https://github.com/rascal999/nixos ${HOME}/git/nixos
# Jupyter templates
mkdir -p ${HOME}/jupyter/pentest/base
rm ${HOME}/jupyter/pentest/base/*.ipynb
rm -rf ${HOME}/jupyter/pentest/base/tools
cp ${HOME}/git/nixos/resources/jupyter/pentest/*.ipynb ${HOME}/jupyter/pentest/base
# Mullvad VPN
echo -n "Placing VPN profiles.."
rm -rf ${HOME}/vpn || true
/run/current-system/sw/bin/tar xf /etc/vpn-mullvad -C ${HOME} || true
echo "Done"
