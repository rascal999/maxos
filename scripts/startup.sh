git clone https://github.com/rascal999/nixos ${HOME}/git/nixos || git -C ${HOME}/git/nixos pull
mkdir -p ${HOME}/jupyter/pentest/base
rm ${HOME}/jupyter/pentest/base/*.ipynb
cp ${HOME}/git/nixos/resources/jupyter/pentest/*.ipynb ${HOME}/jupyter/pentest/base
