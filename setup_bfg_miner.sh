#!/bin/bash

# Step 0: Set absolute paths
current_dir=$(realpath "$(dirname "$0")")
bfgminer_dir="$current_dir/../bfgminer"

# Step 1: Update the system
sudo apt update
sudo apt upgrade -y

# Step 2: Install dependencies
sudo apt install -y automake autoconf libtool pkg-config libcurl4-gnutls-dev libjansson-dev uthash-dev
sudo apt install -y libevent-dev

# Step 3: Replace git: with https: in .gitmodules
sed -i 's/git:/https:/g' "$bfgminer_dir/.gitmodules"

# Set config to use HTTPS instead of git for GitHub
git config --global url.https://github.com/.insteadOf git://github.com/

# Step 4: Go up one directory and clone BFGMiner from GitHub or pull latest if already cloned
if [ -d "$bfgminer_dir" ]; then
    cd "$bfgminer_dir"
    git config pull.ff only
    git pull
else
    cd "$current_dir" # Move back to the current directory before cloning
    git clone https://github.com/luke-jr/bfgminer "$bfgminer_dir"
    cd "$bfgminer_dir"
fi

# Update and initialize submodules
GIT_TRACE=1 GIT_CURL_VERBOSE=1 git submodule update --init --recursive

# Step 5: Configure UTF8
# Check if en_US.utf8 is available in the locale options
if locale -a | grep -q "en_US.utf8"; then
    echo "en_US.utf8 is available in the locale options."

    # Set en_US.utf8 as the default locale
    sudo update-locale LANG=en_US.utf8
    echo "en_US.utf8 has been set as the default locale."
else
    echo "en_US.utf8 is not available in the locale options."
    echo "Please choose an appropriate locale that supports UTF-8 encoding."
    exit 1
fi

# Step 6: Build BFGMiner
./autogen.sh
./configure
make

# Step 7: Configure Bitcoin Core
bitcoin_conf_path=~/.bitcoin/bitcoin.conf

# Check if the configuration lines are already present
if ! grep -q "server=1" "$bitcoin_conf_path" || ! grep -q "rpcuser=" "$bitcoin_conf_path" || ! grep -q "rpcpassword=" "$bitcoin_conf_path"; then
    default_rpc_user="raspibolt"
    read -p "Enter the RPC username (rpcuser, default: $default_rpc_user): " rpc_user
    rpc_user=${rpc_user:-$default_rpc_user} # Set default value if the input is empty
    read -s -p "Enter the RPC password (passwordB): " rpc_password
    echo -e "\nserver=1" >> "$bitcoin_conf_path"
    echo "rpcuser=$rpc_user" >> "$bitcoin_conf_path"
    echo "rpcpassword=$rpc_password" >> "$bitcoin_conf_path"
fi

# Step 8: Start BFGMiner
mining_address=$(./get_new_address.sh)
read -p "Enter your Bitcoin address to mine to: " mining_address
# ./bfgminer -T -D -P -o '127.0.0.1:8332' -O user:pass --stratum-port 3334 --generate-to $mining_address


