#!/usr/bin/env bash

usage() {
  echo "Net scan script"
  echo "Usage: $0 -n <scan-name> -t <targets-file> [-i <interface>]" 1>&2;
  echo
  echo "-n (Scan name)      Name of scan"
  echo "-t (Targets file)   Targets file"
  echo "-i (Interface)      Interface to scan from"
  echo
  echo "Examples:"
  echo "# Basic usage"
  echo "$0 -n client_name -t ranges.txt -i eth0"
  echo
  exit 1;
}

arg_auto_interface="false"
arg_interface="false"
arg_mac="false"
arg_name="false"
arg_router_ip="false"
arg_targets="false"

while getopts "i:n:r:s:t:" flag
do
    case "${flag}" in
        i) arg_interface="${OPTARG}";;
        n) arg_name="${OPTARG}";;
        r) arg_router_ip="${OPTARG}";;
        s) arg_mac=${OPTARG};;
        t) arg_targets=${OPTARG};;
    esac
done

# Make sure user selects required options
if [[ "$arg_name" == "false" || "$arg_targets" == "false" ]]; then
  echo "ERROR: Scan name and/or targets not provided"
  echo
  usage
fi

# Check target range/IP file is a file
if [[ ! -f "$arg_targets" ]]; then
  echo "ERROR: Not a valid target file"
  echo
  usage
fi

# Select interface or bail on fail
if [[ "$arg_interface" == "false" ]]; then
  arg_interface=`ip r | grep default | choose 4`
  arg_auto_interface="true"

  if [[ "$arg_interface" == "" ]]; then
    echo "ERROR: Unable to automatically select an interface to scan from"
    exit 1
  fi
  echo "INFO: Selected $arg_interface network interface for scanning.."
  #sleep 5
fi

NOW=`date "+%Y%m%d_%H%M%S"`
RESULTS_DIR="/home/user/scans/${NOW}_${arg_name}"
mkdir -p $RESULTS_DIR
firefox $RESULTS_DIR

echo

# Ping sweep
echo "### Ping sweep"
sudo time nmap -e $arg_interface -iL $arg_targets -sn -n -T4 -oA ${RESULTS_DIR}/nmap_ping_scan

echo "### These hosts responded to ping sweep (ICMP)" > ${RESULTS_DIR}/results_nmap_ping_scan.txt
echo >> ${RESULTS_DIR}/results_nmap_ping_scan.txt
cat ${RESULTS_DIR}/nmap_ping_scan.gnmap | grep "Status: Up" | choose 1 >> ${RESULTS_DIR}/results_nmap_ping_scan.txt
echo

# masscan TCP top 100
echo "### Masscan TCP top 100"
if [[ "$arg_auto_interface" == "true" ]]; then
  cp $arg_targets $RESULTS_DIR
  arg_targets_file=`echo $arg_targets | choose --field-separator '/' -1`

  time docker run --rm -v "${RESULTS_DIR}:/mnt" ilyaglow/masscan -iL /mnt/$arg_targets_file --top-ports=100 --rate=5000 -oB /mnt/masscan_tcp_top_100.bin
else
  sudo time masscan -iL $arg_targets --interface $arg_interface --top-ports=100 --rate=5000 -oB ${RESULTS_DIR}/masscan_tcp_top_100.bin
fi

sudo masscan --readscan ${RESULTS_DIR}/masscan_tcp_top_100.bin -oG ${RESULTS_DIR}/masscan_tcp_top_100.grep
sudo masscan --readscan ${RESULTS_DIR}/masscan_tcp_top_100.bin -oJ ${RESULTS_DIR}/masscan_tcp_top_100.json
sudo masscan --readscan ${RESULTS_DIR}/masscan_tcp_top_100.bin -oX ${RESULTS_DIR}/masscan_tcp_top_100.xml

echo "### Masscan open TCP ports (top 100)" > ${RESULTS_DIR}/results_masscan_tcp_top_100.txt 
echo >> ${RESULTS_DIR}/results_masscan_tcp_top_100.txt
cat ${RESULTS_DIR}/masscan_tcp_top_100.grep | grep -E "^Timestamp: " | choose 3 6 | cut -d '/' -f 1 | sed 's/ /:/g' | sort -V >> ${RESULTS_DIR}/results_masscan_tcp_top_100.txt
echo

# masscan TCP all
echo "### Masscan TCP all"
if [[ "$arg_auto_interface" == "true" ]]; then
  time docker run --rm -v "${RESULTS_DIR}:/mnt" ilyaglow/masscan -iL /mnt/$arg_targets_file -p - --rate=5000 -oB /mnt/masscan_tcp_all.bin
else
  sudo time masscan -iL $arg_targets --interface $arg_interface --top-ports=100 --rate=5000 -oB ${RESULTS_DIR}/masscan_tcp_all.bin
fi

sudo masscan --readscan ${RESULTS_DIR}/masscan_tcp_all.bin -oG ${RESULTS_DIR}/masscan_tcp_all.grep
sudo masscan --readscan ${RESULTS_DIR}/masscan_tcp_all.bin -oJ ${RESULTS_DIR}/masscan_tcp_all.json
sudo masscan --readscan ${RESULTS_DIR}/masscan_tcp_all.bin -oX ${RESULTS_DIR}/masscan_tcp_all.xml

echo "### Masscan open TCP ports (all)" > ${RESULTS_DIR}/results_masscan_tcp_all.txt 
echo >> ${RESULTS_DIR}/results_masscan_tcp_all.txt
cat ${RESULTS_DIR}/masscan_tcp_all.grep | grep -E "^Timestamp: " | choose 3 6 | cut -d '/' -f 1 | sed 's/ /:/g' | sort -V >> ${RESULTS_DIR}/results_masscan_tcp_all.txt
echo

# nmap TCP all
echo "### nmap TCP all"
sudo time nmap -Pn -A -e $arg_interface -p - -n -T4 -iL $arg_targets -oA ${RESULTS_DIR}/nmap_tcp_all
echo

# nmap SCTP all
echo "### nmap SCTP all"
sudo time nmap -Pn -A -e $arg_interface -T4 -sY -iL $arg_targets -p - -oA ${RESULTS_DIR}/nmap_sctp_scan
echo

# nmap UDP common
echo "### nmap UDP common"
sudo time nmap -Pn -A -e $arg_interface -T4 -sU -iL $arg_targets -oA ${RESULTS_DIR}/nmap_udp_scan
