#!/bin/bash

# Step 0: Set absolute paths
current_dir=$(cd "$(dirname "$0")" && pwd)

# Set config to use HTTPS instead of git for GitHub
git config --global url.https://github.com/.insteadOf git://github.com/

# Step 1: Create $current_dir/../discover_script if it doesn't already exist
discover_script_dir="$current_dir/../discover_script"
if [ ! -d "$discover_script_dir" ]; then
    mkdir -p "$discover_script_dir"
fi

# Step 2: Create a new variable for the path $current_dir/../discover_script/braiins-os
braiins_os_dir="$discover_script_dir/braiins-os"
if [ ! -d "$braiins_os_dir" ]; then
    # Clone the discovery script
    cd "$discover_script_dir" || exit
    git clone https://github.com/papampi/braiins-os.git braiins-os
    cd "$braiins_os_dir"
    virtualenv --python=/usr/bin/python3 .env
    source .env/bin/activate
    python3 -m pip install -r requirements.txt
    python3 -m pip install ruamel.yaml  # Install ruamel.yaml if missing
else
    # Pull latest changes
    cd "$braiins_os_dir" || exit
    git config pull.ff only
    git pull
fi

# Discover S9 miner in the local network
cd "$braiins_os_dir"
echo "Discovering supported mining devices in the local network (Listen mode):"
python3 discover.py listen --format "{IP} ({MAC})"

