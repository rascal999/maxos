#!/usr/bin/env bash

rsync -av --no-perms /home/user/Data/* admin@192.168.0.254:/volume1/syncthing-data/data
