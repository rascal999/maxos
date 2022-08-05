#!/usr/bin/env bash

# Check if sonarqube already running

# Spin up server (change port)
docker run --rm -d --name sonarqube -e SONAR_ES_BOOTSTRAP_CHECKS_DISABLE=true -p 9000:9000 sonarqube:latest

# zzz
sleep 30

# Register

# Create project

# Get keys..

# Run scan

# Get results

# Make results nice?

# Kill SQ?
