#!/usr/bin/env bash

setxkbmap gb -variant dvorakukp

# Function to generate a random string of specified length
generate_random_string() {
    length=$1
    echo -n "#"
    cat /dev/urandom | tr -dc 'a-f0-9' | fold -w $length | head -n 1
}

# Generate a random string of 10 characters
random_string=$(generate_random_string 6)

sleep 0.2

# Use xdotool to type the random string
xdotool type "$random_string"
