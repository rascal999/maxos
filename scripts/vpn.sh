#!/usr/bin/env bash

# Features
## Select random VPN
### a-vpn -s
## Select random VPN based on location
### a-vpn -s -l gb
## Kill VPN
### a-vpn -k

#!/usr/bin/env bash

usage() {
  echo "VPN script script"
  echo "Usage: $0 [-k] [-L] [-l] [-s]" 1>&2;
  echo
  echo "-k (Kill)        Kill VPN"
  echo "-L (List)        List VPN regions"
  echo "-l (Location)    VPN Location"
  echo "-s (Start)       Start VPN"
  echo
  echo "Examples:"
  echo "# Selecet a random VPN"
  echo "$0 -s"
  echo
  echo "# Select a random VPN in location"
  echo "$0 -s -l gb"
  exit 1;
}

arg_kill=0
arg_list=0
arg_location="empty"
arg_start=0

while getopts kLl:s flag
do
    case "${flag}" in
        k) arg_kill=1;;
        L) arg_list=1;;
        l) arg_location=${OPTARG};;
        s) arg_start=1;;
    esac
done

# No options specified?
if [[ "$((${arg_kill}+${arg_list}+${arg_start}))" == "0" ]]; then
    usage
fi

if [[ "$arg_start" == "1" ]]; then
  MULLVAD_PROFILE_COUNT=`sudo nmcli connection show | grep mullvad | wc -l`
  if [[ "$MULLVAD_PROFILE_COUNT" != "0" ]]; then
    echo "ERROR: Existing Mullvad profile, delete first."
    exit 1
  fi

  if [[ "$arg_location" == "empty" ]]; then
    VPN_PROFILE=`find $HOME/vpn/ -type f -name "*.conf" | sort -R | tail -1`
  else
    VPN_PROFILE=`find $HOME/vpn/ -type f -name "${arg_location}*.conf" | sort -R | tail -1`
  fi

  sudo nmcli connection import type wireguard file $VPN_PROFILE
fi

if [[ "$arg_kill" == "1" ]]; then
  MULLVAD_PROFILE=`sudo nmcli connection show | grep -E "wg|wireguard" | choose 0`

  if [[ "$MULLVAD_PROFILE" != "" ]]; then
    sudo nmcli connection delete $MULLVAD_PROFILE
  else
    echo "ERROR: No Mullvad profiles to remove."
    exit 1
  fi
fi

if [[ "$arg_list" == "1" ]]; then
  echo "Profiles by region:"
  echo
  find $HOME/vpn/ -type f -name "*.conf" | choose -f '/' 3 | choose -c 0:1 | sort | uniq -c | sort -h
fi
