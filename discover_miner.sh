#!/bin/bash

# Function to determine the local IP address
get_local_ip() {
    ifconfig | grep 'inet ' | grep -v 127.0.0.1 | awk '{print $2}'
}

# Function to install nmap
install_nmap() {
    echo "Installing nmap..."
    if [[ $(command -v apt) ]]; then
        sudo apt update
        sudo apt install -y nmap
    elif [[ $(command -v yum) ]]; then
        sudo yum install -y nmap
    elif [[ $(command -v brew) ]]; then
        brew install nmap
    else
        echo "Error: Could not find a package manager to install nmap."
        exit 1
    fi
}

# Function to run the nmap scan
run_nmap_scan() {
    local local_ip_range="$1"
    nmap -sn "$local_ip_range"
}

# Main script
if [[ ! $(command -v nmap) ]]; then
    install_nmap
fi

local_ip_range=$(get_local_ip | awk -F'.' '{print $1"."$2"."$3".0/24"}')

echo "Running nmap scan on the local network..."
echo "Local IP range: $local_ip_range"
run_nmap_scan "$local_ip_range"
