#!/usr/bin/env python3

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
    parser.add_argument("--masscan", required=False,
                        help="Masscan JSON file to parse")

    parsed = parser.parse_args()

    ips = parse_masscan(parsed.masscan)
    output(ips)

def output(data):
  data_sorted = sorted(data.items(), key=lambda item: socket.inet_aton(item[0]))
  #print(data_sorted)
  uuid_str = str(uuid.uuid4()).split('-')[0]
  for ip in data_sorted:
    print("- # " + ip[0])
    print("\t- ## TCP")
    for port in sorted(data[ip[0]]):
      print("\t\t- TODO [" + ip[0] + ":" + str(port) + "]([[" + uuid_str + " " + ip[0] + " TCP " + str(port) + "]])")

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
