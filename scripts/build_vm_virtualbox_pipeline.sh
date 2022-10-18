#!/usr/bin/env bash

GIT_CURRENT_HASH=`sudo -u user git -C /home/user/git/maxos rev-parse --short HEAD`

# build
/home/user/git/maxos/scripts/build_vm_virtualbox.sh -n && \
ssh user@alm.gg mv /home/user/alm.gg/www/maxos_kde.ova /home/user/alm.gg/www/maxos_kde_previous.ova || true && \
rsync -av /home/user/git/maxos/maxos_virtualbox/maxos.ova user@alm.gg:/home/user/alm.gg/www/maxos_kde.ova && \
ssh user@alm.gg touch /home/user/alm.gg/www/maxos_kde.ova && \
/home/user/git/maxos/scripts/telegram_notify.sh -m "VirtualBox VM built and pushed to https://alm.gg for $GIT_CURRENT_HASH"