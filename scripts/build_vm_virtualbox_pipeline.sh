#!/usr/bin/env bash

GIT_CURRENT_HASH=`sudo -u user git -C /home/user/git/maxos rev-parse --short HEAD`

# build
/home/user/git/maxos/scripts/build_vm_virtualbox.sh -c vm_virtualbox -n && \
ssh root@alm.gg sudo mv /home/user/alm.gg/www/maxos_kde.ova /home/user/alm.gg/www/maxos_kde_previous.ova || true && \
rsync --progress -av /home/user/git/maxos/maxos_vm_virtualbox/maxos.ova root@alm.gg:/home/user/alm.gg/www/maxos_kde.ova && \
ssh root@alm.gg touch /home/user/alm.gg/www/maxos_kde.ova && \
/home/user/git/maxos/scripts/telegram_notify.sh -m "VirtualBox VM built and pushed to https://alm.gg for $GIT_CURRENT_HASH"
