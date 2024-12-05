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
curl -s -o /dev/null -w "BBC HTTP code: %{http_code}\n" https://www.bbc.co.uk/
echo
ping -w2 -c1 -q 8.8.8.8 | grep -E "stat|packets "
echo
ping -w2 -c1 -q 10.44.0.1 | grep -E "stat|packets "

if [[ "${PIPESTATUS[0]}" == "0" ]]; then
    echo -e "${GREEN}### ALL OK ###${NC}"
else
    echo -e "${RED}###>>> ERROR! PLEASE TAKE A PICTURE OF THIS SCREEN AND EMAIL TO US <<<###${NC}"
fi
