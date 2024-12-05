#!/usr/bin/env python3

import argparse
import configparser
import docker
import glob
import hashlib
import json
import os
import requests
import subprocess as sp
import sys
import time
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
  print("SonarQube init script")
  print()

def main():
    parser = argparse.ArgumentParser(description="Prepare fresh SonarQube and fetch key.")
    parser.add_argument("--url", required=False, default="http://localhost:9000",
                        help="SQ URL (default: http://localhost:9000)")

    parsed = parser.parse_args()

    welcome()

    proxies = {
       'http': 'http://localhost:8080',
    }

    # CHECK ALIVE AND AUTH
    print("Checking endpoint and authenticating.. ", end="", flush=True)
    endpoint_auth_response_length = -1

    while endpoint_auth_response_length != 0:
      session = requests.session()
      target_url = parsed.url + "/api/authentication/login"
      target_data = {"login": "admin", "password": "admin"}

      endpoint_auth_response = session.post(target_url, data=target_data, proxies=proxies)
      endpoint_auth_response_length = len(endpoint_auth_response.text)

      if endpoint_auth_response.status_code == 401:
        print("ERROR: Auth endpoint HTTP 401, SonarQube already running?")
        sys.exit(1)

      time.sleep(5)

    print("OK")

    # CREATE PROJECT
    print("Creating project.. ", end="", flush=True)
    target_url = parsed.url + "/api/projects/create"
    target_data = {"project": "scan", "name": "scan"}

    try:
      endpoint_create_project_response = session.post(target_url, data=target_data, headers={"X-XSRF-TOKEN":session.cookies['XSRF-TOKEN']}, proxies=proxies)
    except:
      print("ERROR")
      sys.exit(1)

    if endpoint_create_project_response.status_code != 200:
      print("ERROR")
      sys.exit(1)

    print("OK")

    # CREATE AND FETCH PROJECT TOKEN
    print("Creating and fetching project token.. ", end="", flush=True)
    target_url = parsed.url + "/api/user_tokens/generate"
    target_data = {"name": "Analyze \"scan\"", "type": "PROJECT_ANALYSIS_TOKEN", "projectKey": "scan"}
    endpoint_create_fetch_token = session.post(target_url, data=target_data, headers={"X-XSRF-TOKEN":session.cookies['XSRF-TOKEN']}, proxies=proxies)
    if endpoint_create_fetch_token.status_code != 200:
      print("ERROR")
      sys.exit(1)

    print("OK")
    sq_token = json.loads(endpoint_create_fetch_token.text)['token']
    print("Token: " + sq_token)

    sq_ip = sp.getoutput("docker inspect `docker ps -a | grep sonarqube | choose 0` | jq -r '.[].NetworkSettings.IPAddress'")

    # RUN SCANNER
    os.system("docker run \
      --rm \
      -e SONAR_HOST_URL='http://" + str(sq_ip) + ":9000' \
      -e SONAR_LOGIN='" + sq_token + "' \
      -v '" + os.getcwd() + ":/usr/src' \
      sonarsource/sonar-scanner-cli -Dsonar.projectKey=scan")

if __name__ == "__main__":
    main()
