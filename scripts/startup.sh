# Clone nixos
/run/current-system/sw/bin/git clone https://github.com/rascal999/nixos ${HOME}/git/nixos || /run/current-system/sw/bin/git -C ${HOME}/git/nixos pull
# Jupyter templates
mkdir -p ${HOME}/jupyter/pentest/base
rm ${HOME}/jupyter/pentest/base/*.ipynb
rm -rf ${HOME}/jupyter/pentest/base/tools
cp ${HOME}/git/nixos/resources/jupyter/pentest/*.ipynb ${HOME}/jupyter/pentest/base
# Mullvad VPN
mkdir ${HOME}/vpn
tar xvf /etc/vpn-mullvad.tar.gz -C ${HOME}/vpn
