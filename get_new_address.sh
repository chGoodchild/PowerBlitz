#!/bin/bash

# Function to check if bitcoin-cli command is available
check_bitcoin_cli() {
    if ! command -v bitcoin-cli &> /dev/null; then
        echo "Error: bitcoin-cli command not found."
        echo "Make sure Bitcoin Core is installed and in your PATH."
        exit 1
    fi
}

# Check if bitcoin-cli is available
check_bitcoin_cli

# Function to get a new Bitcoin address
get_new_address() {
    local new_address
    # new_address=$(bitcoin-cli getaccountaddress "")
    new_address="bc1q2pwrn2cg9x8ej4uqjg5ttumtrepxc2e2vrxjv5"
    if [ -n "$new_address" ]; then
        # echo "New Bitcoin Address: $new_address"
	echo $new_address
    else
        echo "Error: Failed to get a new Bitcoin address."
        exit 1
    fi
}

# Get a new Bitcoin address
address=$(get_new_address)

echo $address
