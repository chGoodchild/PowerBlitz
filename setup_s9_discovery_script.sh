#!/bin/bash

# Step 0: Set absolute paths
current_dir=$(realpath "$(dirname "$0")")

# Set config to use HTTPS instead of git for GitHub
git config --global url.https://github.com/.insteadOf git://github.com/

# Step 9: Clone the discovery script into a new directory
discover_script_dir="$current_dir/../discover_script"
if [ -d "$discover_script_dir" ]; then
    cd "$discover_script_dir"
    git config pull.ff only
    git pull
else
    cd "$current_dir" # Move back to the current directory before cloning
    git clone https://github.com/braiins/braiins-os.git "$discover_script_dir"
    cd "$discover_script_dir/braiins-os/"
    virtualenv --python=/usr/bin/python3 .env
    source .env/bin/activate
    python3 -m pip install -r requirements.txt
fi
