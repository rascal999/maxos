#!/usr/bin/env bash

# Run docker commands
docker run --rm -v ghunt-resources:/usr/src/app/resources -ti ghcr.io/mxrch/ghunt check_and_gen.py
docker run --rm -v ghunt-resources:/usr/src/app/resources -ti ghcr.io/mxrch/ghunt ghunt.py
