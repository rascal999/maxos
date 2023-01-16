#!/usr/bin/env zsh

# Check targets file
if [[ ! -f "targets.txt" ]]; then
  echo "ERROR: Specify domains in targets.txt"
  return 1
fi

# Pentester details
curl https://ifconfig.me/ > tester_ip.txt
date > tester_date_start.txt
ip a > tester_interface_info.txt

NOW=`date "+%Y%m%d %H%M%S"`
echo "[$NOW] Started EyeWitness.." >> progress.log
# EyeWitness
docker run -d --rm -it -v $PWD:/tmp/EyeWitness eyewitness -f /tmp/EyeWitness/targets.txt -d /tmp/EyeWitness/eyewitness_$TIMESTAMP

while read target; do
  # Alive check on hosts
  NOW=`date "+%Y%m%d %H%M%S"`
  echo "[$NOW] Started curl.." >> progress.log

  curl -k --connect-timeout 10 $target 2>&1 > /dev/null
  if [[ "$?" == "0" ]]; then
    echo $target >> target_alive.txt
  fi

  # Title banner grab

  # Port scan

  # Spider
done<targets.txt

# End
date > tester_date_end.txt
