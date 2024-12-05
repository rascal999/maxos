#!/usr/bin/env python3

from os.path import exists

import argparse
import collections
import configparser
import docker
import glob
import hashlib
import ipaddress
import json
import os
import requests
import socket
import subprocess as sp
import sys
import time
import uuid
#import xmltodict, json

class bcolours:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

def welcome():
  print("masscan/nmap Logseq parser")
  print()

def main():
    parser = argparse.ArgumentParser(description="Parse masscan/nmap/asn files for Logseq.")
    parser.add_argument("--masscan", required=True,
                        help="Masscan JSON file to parse")
    parser.add_argument("--output", required=False, default="logseq.md",
                        help="logseq output file location (default: logseq.md)")
    parser.add_argument("--asn", required=False, default=False,
                        help="Directory with ASN JSON results")

    parsed = parser.parse_args()

    ips = parse_masscan(parsed.masscan)
    output(parsed, ips)

def output_asn(parsed,ip):
  asn_file = parsed.asn + "/asn_" + ip + ".json"

  file_exists = exists(asn_file)
  if file_exists != True:
    print("WARNING: " + asn_file + " doesn't exist")
    output_str = \
"""\t- ```
 Could not fetch ANS info
\t  ```
"""
  else:
    print("INFO: Processing " + asn_file)
    asn_fd = open(asn_file)
    data = json.load(asn_fd)

    asn_reverse_name = "N/A"
    asn_known_as = "N/A"
    asn_net_range = "N/A"
    asn_org_name = "N/A"
    asn_net_name = "N/A"
    asn_name = "N/A"
    asn = "N/A"
    asn_reputation_status = "N/A"

    try:
      asn_reverse_name = data['results'][0]['reverse']
    except:
      pass
    try:
      asn_known_as = data['results'][0]['reputation']['known_as']
    except:
      pass
    try:
      asn_net_range = data['results'][0]['routing']['route']
    except:
      pass
    try:
      asn_org_name = data['results'][0]['org_name']
    except:
      pass
    try:
      asn_net_name = data['results'][0]['net_name']
    except:
      pass
    try:
      asn_name = data['results'][0]['routing']['as_name']
    except:
      pass
    try:
      asn = data['results'][0]['routing']['as_number']
    except:
      pass
    try:
      asn_reputation_status = data['results'][0]['reputation']['status']
    except:
      pass

    output_str = \
"""\t- ```
 Reverse name: """ + asn_reverse_name + """
 Known as: """ + asn_known_as + """
 Net range: """ + asn_net_range + """
 Organisation: """ + asn_org_name  + """
 Net name: """ + asn_net_name + """
 AS Name: """ + asn_name + """
 ASN: """ + asn + """
 Reputation: """ + asn_reputation_status + """
```
"""
  return str(output_str)

def output(parsed,data):
  file_exists = exists(parsed.output)
  if file_exists:
    print("ERROR: " + parsed.output + " exists, bailing")
    sys.exit(1)

  f = open(parsed.output, "a")

  data_sorted = sorted(data.items(), key=lambda item: socket.inet_aton(item[0]))
  uuid_str = str(uuid.uuid4()).split('-')[0]

  for ip in data_sorted:
    f.write("- ## " + ip[0] + "\n")

    # Include ASN info
    if parsed.asn != False:
      f.write(output_asn(parsed,ip[0]))

    f.write("\t- ### TCP" + "\n")
    for port in sorted(data[ip[0]]):
      f.write("\t\t- TODO [" + ip[0] + ":" + str(port) + "]([[" + uuid_str + " " + ip[0] + " TCP " + str(port) + "]])\n")
      f.write("\t\t\t- XXX\n")

def parse_masscan(file_masscan):
    # Opening JSON file
    f = open(file_masscan)

    # returns JSON object as
    # a dictionary
    data = json.load(f)

    # Process masscan file
    ip = {}

    for block in data:
      block_ip = block['ip']

      if block_ip not in ip:
        ip[block_ip] = []
      ip[block_ip].append(block['ports'][0]['port'])

    return ip

if __name__ == "__main__":
    main()
