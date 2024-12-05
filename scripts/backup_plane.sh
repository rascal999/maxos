#!/usr/bin/env bash

rsync -av --no-perms /var/lib/docker/volumes/plane_pgdata/ /home/user/Data/plane
chown user:users /home/user/Data/plane -R
