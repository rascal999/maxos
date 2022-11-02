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
    parser = argparse.ArgumentParser(description="Parse masscan/nmap files for Logseq.")
    parser.add_argument("--masscan", required=True,
                        help="Masscan JSON file to parse")
    parser.add_argument("--output", required=False, default="logseq.md",
                        help="logseq output file location (default: logseq.md)")

    parsed = parser.parse_args()

    ips = parse_masscan(parsed.masscan)
    output(ips, parsed.output)

def output(data, output_file):
  file_exists = exists(output_file)
  if file_exists:
    print("ERROR: " + output_file + " exists, bailing")
    sys.exit(1)

  f = open(output_file, "a")

  data_sorted = sorted(data.items(), key=lambda item: socket.inet_aton(item[0]))
  uuid_str = str(uuid.uuid4()).split('-')[0]

  for ip in data_sorted:
    f.write("- # " + ip[0] + "\n")
    f.write("\t- ## TCP" + "\n")
    for port in sorted(data[ip[0]]):
      f.write("\t\t- TODO [" + ip[0] + ":" + str(port) + "]([[" + uuid_str + " " + ip[0] + " TCP " + str(port) + "]])\n")

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
