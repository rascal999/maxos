#!/usr/bin/env python3

from os.path import exists

import argparse
import ipaddress

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
  print("Get all IPs from range list")
  print()

def main():
    parser = argparse.ArgumentParser(description="Print all IP addresses given ranges.")
    parser.add_argument("--input", required=True,
                        help="File containing ranges")

    parsed = parser.parse_args()

    # Open file
    f = open(parsed.input).readlines()

    for ip_range in f:
      # For each range
      for ip in ipaddress.IPv4Network(ip_range.strip()):
        print(ip)
      #print([str(ip) for ip in ipaddress.IPv4Network("192.168.0.0/24")])

if __name__ == "__main__":
    main()
