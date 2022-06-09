#!/usr/bin/env bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

ip a | grep -Ev "inet6|valid|link/ether"
echo
ip r
echo
nmcli con | grep wg_
echo
ping -c1 -w4 10.44.0.1

if [[ "$?" == "0" ]]; then
    echo -e "${GREEN}##############"
    echo -e "### ALL OK ###"
    echo -e "##############${NC}"
else
    echo -e "${RED}###################################################################"
    echo -e "### ERROR! PLEASE TAKE A PICTURE OF THIS SCREEN AND EMAIL TO US ###"
    echo -e "###################################################################${NC}"
fi
