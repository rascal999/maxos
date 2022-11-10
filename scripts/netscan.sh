#!/usr/bin/env bash

usage() {
  echo "Net scan script"
  echo "Usage: $0 -n <scan-name> -t <targets-file> [-d] [-i <interface>] [-p]" 1>&2;
  echo
  echo "-a (alert)           Alert on scan completion"
  echo "-d (Docker masscan)  Use masscan in docker image (if you're having interface trouble)"
  echo "-n (Scan name)       Name of scan"
  echo "-p (Ping scan)       Ping scan only"
  echo "-t (Targets file)    Targets file"
  echo "-i (Interface)       Interface to scan from"
  echo
  echo "Examples:"
  echo "# Basic usage"
  echo "$0 -n client_name -t ranges.txt -i eth0"
  echo
  exit 1;
}

arg_alert="false"
arg_auto_interface="false"
arg_interface="false"
arg_mac="false"
arg_masscan_docker="false"
arg_name="false"
arg_ping_scan_only="false"
arg_router_ip="false"
arg_targets="false"

RED='\033[0;31m'
NC='\033[0m' # No Color

while getopts "adi:n:pr:s:t:" flag
do
    case "${flag}" in
        a) arg_alert="true";;
        d) arg_masscan_docker="true";;
        i) arg_interface="${OPTARG}";;
        n) arg_name="${OPTARG}";;
        p) arg_ping_scan_only="true";;
        r) arg_router_ip="${OPTARG}";;
        s) arg_mac=${OPTARG};;
        t) arg_targets=${OPTARG};;
    esac
done

# Make sure user selects required options
if [[ "$arg_name" == "false" || "$arg_targets" == "false" ]]; then
  printf "${RED}ERROR:${NC} Scan name and/or targets not provided\n"
  echo
  usage
fi

# Check target range/IP file is a file
if [[ ! -f "$arg_targets" ]]; then
  printf "${RED}ERROR:${NC} Not a valid target file\n"
  echo
  usage
fi

# Check individual IPs per line
no_ranges=`grep -E "[-/]" $arg_targets | wc -l`
if [[ "$no_ranges" != "0" ]]; then
  printf "${RED}ERROR:${NC} One IP per line\n"
  echo
  usage
fi

# Remove spaces in file
sed -i 's/[ \t]//g' $arg_targets

# Select interface or bail on fail
if [[ "$arg_interface" == "false" ]]; then
  arg_interface=`ip r | grep default | choose 4`
  arg_auto_interface="true"

  if [[ "$arg_interface" == "" ]]; then
    printf "${RED}ERROR:${NC} Unable to automatically select an interface to scan from\n"
    exit 1
  fi
  echo "INFO: Selected $arg_interface network interface for scanning.."
  #sleep 5
fi

NOW=`date "+%Y%m%d_%H%M%S"`
RESULTS_DIR="/home/user/scans/netscan/${NOW}_${arg_name}"
mkdir -p $RESULTS_DIR

# Launch Firefox if $DISPLAY set
if [[ "$DISPLAY" != "" ]]; then
  firefox $RESULTS_DIR
fi

echo

# Tester info
echo "### Tester source IP" > ${RESULTS_DIR}/tester_info.txt
curl https://ifconfig.me >> ${RESULTS_DIR}/tester_info.txt
echo >> ${RESULTS_DIR}/tester_info.txt

echo "### Network scan start date" >> ${RESULTS_DIR}/tester_info.txt
date >> ${RESULTS_DIR}/tester_info.txt
echo >> ${RESULTS_DIR}/tester_info.txt

echo "### Interface information" >> ${RESULTS_DIR}/tester_info.txt
ip a >> ${RESULTS_DIR}/tester_info.txt
echo >> ${RESULTS_DIR}/tester_info.txt

# Ping sweep
echo "### Ping sweep"
sudo time nmap -e $arg_interface -iL $arg_targets -sn -n -T4 -oA ${RESULTS_DIR}/nmap_ping_scan

echo "### These hosts responded to ping sweep" > ${RESULTS_DIR}/results_nmap_ping_scan.txt
echo >> ${RESULTS_DIR}/results_nmap_ping_scan.txt
cat ${RESULTS_DIR}/nmap_ping_scan.gnmap | grep "Status: Up" | choose 1 >> ${RESULTS_DIR}/results_nmap_ping_scan.txt
echo

# Bail if only ping sweeping
if [[ "$arg_ping_scan_only" == "true" ]]; then
  echo "Finished ping sweep.."
  # Alert?
  if [[ "$arg_alert" == "true" ]]; then
    active_host_count=`cat ${RESULTS_DIR}/nmap_ping_scan.gnmap | grep "Status: Up" | choose 1 | wc -l`
    /home/user/git/maxos/scripts/telegram_notify.sh -m "$arg_name netscan finished ping sweep on $arg_interface interface, $active_host_count active host(s)"
  fi
  exit 0
fi

# masscan TCP top 100
echo "### Masscan TCP top 100"
if [[ "$arg_masscan_docker" == "true" || "$arg_auto_interface" == "true" ]]; then
  cp $arg_targets $RESULTS_DIR/targets.txt

  time docker run --rm -v "${RESULTS_DIR}:/mnt" ilyaglow/masscan -iL /mnt/targets.txt --top-ports=100 --rate=5000 -oB /mnt/masscan_tcp_top_100.bin
  if [[ "$?" != "0" ]]; then
    printf "${RED}ERROR:${NC} Masscan error, bailing\n"
    /home/user/git/maxos/scripts/telegram_notify.sh -m "$arg_name netscan failed to finish due to masscan error"
    exit 1
  fi
else
  sudo time masscan -iL $arg_targets --interface $arg_interface --top-ports=100 --rate=5000 -oB ${RESULTS_DIR}/masscan_tcp_top_100.bin
  if [[ "$?" != "0" ]]; then
    printf "${RED}ERROR:${NC} Masscan error, bailing\n"
    /home/user/git/maxos/scripts/telegram_notify.sh -m "$arg_name netscan failed to finish due to masscan error"
    exit 1
  fi
fi

sudo masscan --readscan ${RESULTS_DIR}/masscan_tcp_top_100.bin -oG ${RESULTS_DIR}/masscan_tcp_top_100.grep
sudo masscan --readscan ${RESULTS_DIR}/masscan_tcp_top_100.bin -oJ ${RESULTS_DIR}/masscan_tcp_top_100.json
sudo masscan --readscan ${RESULTS_DIR}/masscan_tcp_top_100.bin -oX ${RESULTS_DIR}/masscan_tcp_top_100.xml

echo "### Masscan open TCP ports (top 100)" > ${RESULTS_DIR}/results_masscan_tcp_top_100.txt 
echo >> ${RESULTS_DIR}/results_masscan_tcp_top_100.txt
cat ${RESULTS_DIR}/masscan_tcp_top_100.grep | grep -E "^Timestamp: " | choose 3 6 | cut -d '/' -f 1 | sed 's/ /:/g' | sort -V >> ${RESULTS_DIR}/results_masscan_tcp_top_100.txt
echo

# ASN
echo "### Gathering ASN info"
cat $arg_targets | grep -vE '^(192\.168|10\.|172\.1[6789]\.|172\.2[0-9]\.|172\.3[01]\.)' > ${RESULTS_DIR}/public_ips.txt
xargs -a ${RESULTS_DIR}/public_ips.txt -P 3 -I % bash -c "/home/user/git/pentest-tools/asn/asn -j % > ${RESULTS_DIR}/asn_%.json"
echo

# masscan TCP all
echo "### Masscan TCP all"
if [[ "$arg_masscan_docker" == "true" || "$arg_auto_interface" == "true" ]]; then
  time docker run --rm -v "${RESULTS_DIR}:/mnt" ilyaglow/masscan -iL /mnt/targets.txt -p 0-65535 --rate=5000 -oB /mnt/masscan_tcp_all.bin
  if [[ "$?" != "0" ]]; then
    printf "${RED}ERROR:${NC} Masscan error, bailing\n"
    /home/user/git/maxos/scripts/telegram_notify.sh -m "$arg_name netscan failed to finish due to masscan error"
    exit 1
  fi
else
  sudo time masscan -iL $arg_targets --interface $arg_interface -p 0-65535 --rate=5000 -oB ${RESULTS_DIR}/masscan_tcp_all.bin
  if [[ "$?" != "0" ]]; then
    printf "${RED}ERROR:${NC} Masscan error, bailing\n"
    /home/user/git/maxos/scripts/telegram_notify.sh -m "$arg_name netscan failed to finish due to masscan error"
    exit 1
  fi
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

echo "### Network scan end date" >> ${RESULTS_DIR}/tester_info.txt
date >> ${RESULTS_DIR}/tester_info.txt
echo >> ${RESULTS_DIR}/tester_info.txt

# Alert?
if [[ "$arg_alert" == "true" ]]; then
  active_host_count=`cat ${RESULTS_DIR}/nmap_ping_scan.gnmap | grep "Status: Up" | choose 1 | wc -l`
  /home/user/git/maxos/scripts/telegram_notify.sh -m "$arg_name netscan finished on $arg_interface interface, $active_host_count active host(s)"
fi

exit 0
