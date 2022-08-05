#!/usr/bin/env python3

import argparse
import configparser
import glob
import hashlib
import os
import requests
import sys
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

def main():
    parser = argparse.ArgumentParser(description="Prepare fresh SonarQube and fetch key.")
    parser.add_argument("--url", required=False, default="http://localhost:9000",
                        help="SQ URL (default: http://localhost:9000)")

    parsed = parser.parse_args()

    # Load config
    config = configparser.ConfigParser()

    # Try connecting to SQ
    # TODO

    proxies = {
       'http': 'http://localhost:8080',
    }

    # AUTH
    session = requests.session()
    burp0_url = "http://localhost:9000/api/authentication/login"
    burp0_data = {"login": "admin", "password": "admin"}
    #session.post(burp0_url, headers=burp0_headers, data=burp0_data)
    session.post(burp0_url, data=burp0_data, proxies=proxies)
    burp0_url = "http://localhost:9000/"
    session.get(burp0_url, proxies=proxies)

    for cookie in session.cookies:
      print(cookie)
    import pdb; pdb.set_trace()

    # CHANGE PASSWORD
    burp0_url = "http://localhost:9000/api/users/change_password"
    #burp0_cookies = {"XSRF-TOKEN": "mojqn42gns32vo6cub103tm2k4", "JWT-SESSION": "eyJhbGciOiJIUzI1NiJ9.eyJsYXN0UmVmcmVzaFRpbWUiOjE2NTk3MDkyNTg1NTgsInhzcmZUb2tlbiI6Im1vanFuNDJnbnMzMnZvNmN1YjEwM3RtMms0IiwianRpIjoiQVlKdVlYczZTNWVlX2RvSTNIaXkiLCJzdWIiOiJBWUp1WVBqalM1ZWVfZG9JMi1RRCIsImlhdCI6MTY1OTcwOTI1OCwiZXhwIjoxNjU5OTY4NDU4fQ.pXc7vZCG6OPTau0OgRW3kVSuv7bT2YJXjA1Nh2NnFOc"}
    #burp0_headers = {"User-Agent": "Mozilla/5.0 (X11; Linux x86_64; rv:101.0) Gecko/20100101 Firefox/101.0", "Accept": "application/json", "Accept-Language": "en-US,en;q=0.5", "Accept-Encoding": "gzip, deflate", "Referer": "http://localhost:9000/account/reset_password", "X-XSRF-TOKEN": "mojqn42gns32vo6cub103tm2k4", "Content-Type": "application/x-www-form-urlencoded", "Origin": "http://localhost:9000", "DNT": "1", "Connection": "close", "Sec-Fetch-Dest": "empty", "Sec-Fetch-Mode": "cors", "Sec-Fetch-Site": "same-origin"}
    burp0_data = {"login": "admin", "password": "testtest", "previousPassword": "admin"}
    session.post(burp0_url, data=burp0_data, proxies=proxies)


    # CREATE PROJECT
    burp0_url = "http://localhost:9000/api/projects/create"
    #burp0_cookies = {"XSRF-TOKEN": "2s6u4rcnepc0qdu9t1oehq37d0", "JWT-SESSION": "eyJhbGciOiJIUzI1NiJ9.eyJsYXN0UmVmcmVzaFRpbWUiOjE2NTk3MDkyOTQ2MjgsInhzcmZUb2tlbiI6IjJzNnU0cmNuZXBjMHFkdTl0MW9laHEzN2QwIiwianRpIjoiQVlKdVlnZ2tTNWVlX2RvSTNIaXoiLCJzdWIiOiJBWUp1WVBqalM1ZWVfZG9JMi1RRCIsImlhdCI6MTY1OTcwOTI5NCwiZXhwIjoxNjU5OTY4NDk0fQ.tl7sVDLn2EMy-VKMEi_ZUeShOLoSpIJPsQDs0dFX5BI"}
    #burp0_headers = {"User-Agent": "Mozilla/5.0 (X11; Linux x86_64; rv:101.0) Gecko/20100101 Firefox/101.0", "Accept": "application/json", "Accept-Language": "en-US,en;q=0.5", "Accept-Encoding": "gzip, deflate", "Referer": "http://localhost:9000/projects/create?mode=manual", "X-XSRF-TOKEN": "2s6u4rcnepc0qdu9t1oehq37d0", "Content-Type": "application/x-www-form-urlencoded", "Origin": "http://localhost:9000", "DNT": "1", "Connection": "close", "Sec-Fetch-Dest": "empty", "Sec-Fetch-Mode": "cors", "Sec-Fetch-Site": "same-origin"}
    burp0_data = {"project": "scan", "name": "scan"}
    session.post(burp0_url, data=burp0_data, proxies=proxies)

    # CREATE AND FETCH PROJECT TOKEN
    burp0_url = "http://localhost:9000/api/user_tokens/generate"
    #burp0_cookies = {"XSRF-TOKEN": "2s6u4rcnepc0qdu9t1oehq37d0", "JWT-SESSION": "eyJhbGciOiJIUzI1NiJ9.eyJsYXN0UmVmcmVzaFRpbWUiOjE2NTk3MDkyOTQ2MjgsInhzcmZUb2tlbiI6IjJzNnU0cmNuZXBjMHFkdTl0MW9laHEzN2QwIiwianRpIjoiQVlKdVlnZ2tTNWVlX2RvSTNIaXoiLCJzdWIiOiJBWUp1WVBqalM1ZWVfZG9JMi1RRCIsImlhdCI6MTY1OTcwOTI5NCwiZXhwIjoxNjU5OTY4NDk0fQ.tl7sVDLn2EMy-VKMEi_ZUeShOLoSpIJPsQDs0dFX5BI"}
    #burp0_headers = {"User-Agent": "Mozilla/5.0 (X11; Linux x86_64; rv:101.0) Gecko/20100101 Firefox/101.0", "Accept": "application/json", "Accept-Language": "en-US,en;q=0.5", "Accept-Encoding": "gzip, deflate", "Referer": "http://localhost:9000/dashboard?id=scan&selectedTutorial=manual", "X-XSRF-TOKEN": "2s6u4rcnepc0qdu9t1oehq37d0", "Content-Type": "application/x-www-form-urlencoded", "Origin": "http://localhost:9000", "DNT": "1", "Connection": "close", "Sec-Fetch-Dest": "empty", "Sec-Fetch-Mode": "cors", "Sec-Fetch-Site": "same-origin"}
    burp0_data = {"name": "Analyze \"scan\"", "type": "PROJECT_ANALYSIS_TOKEN", "projectKey": "scan"}
    session.post(burp0_url, data=burp0_data, proxies=proxies)

if __name__ == "__main__":
    main()
