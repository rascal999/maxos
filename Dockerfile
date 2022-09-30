FROM nixos/nix

WORKDIR /root/maxos

RUN nix profile install nixpkgs#gawk nixpkgs#sysctl nixpkgs#vim --extra-experimental-features nix-command --extra-experimental-features flakes
COPY config/nix.conf /root/.config/nix

RUN git clone https://github.com/rascal999/maxos.git /root/maxos
ENTRYPOINT ["/root/maxos/scripts/build_vm_virtualbox_docker.sh"]
