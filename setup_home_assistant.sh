#!/bin/bash

# Function to check if a package is installed
package_installed() {
    dpkg -l "$1" &> /dev/null
}

# Update and upgrade the system
sudo apt-get update
sudo apt-get upgrade -y

# Array of required dependencies
declare -a dependencies=("python3" "python3-dev" "python3-venv" "python3-pip" "bluez" "libffi-dev" "libssl-dev" "libjpeg-dev" "zlib1g-dev" "autoconf" "build-essential" "libopenjp2-7" "libtiff5" "libturbojpeg0-dev" "tzdata" "ffmpeg" "liblapack3" "liblapack-dev" "libatlas-base-dev")

# Check and install required dependencies
for package in "${dependencies[@]}"; do
    if ! package_installed "$package"; then
        sudo apt-get install -y "$package"
    else
        echo "$package is already installed."
    fi
done

# Create a user account for Home Assistant Core
sudo useradd -rm homeassistant -G dialout,gpio,i2c

# Create the installation directory and change owner
sudo mkdir /srv/homeassistant
sudo chown homeassistant:homeassistant /srv/homeassistant

# Create and activate a virtual environment for Home Assistant Core
sudo -u homeassistant -H -s <<EOF
cd /srv/homeassistant
python3 -m venv .
source bin/activate
python3 -m pip install wheel
pip3 install homeassistant==2023.7.2
EOF

# Start Home Assistant Core for the first time
sudo -u homeassistant -H -s hass

# Optional: Allow Home Assistant to run on port 80
# Note: This step requires root privileges, and you should be cautious when opening ports.
# sudo setcap 'cap_net_bind_service=+ep' /srv/homeassistant/bin/python3

# Done!
echo "Home Assistant Core installation completed!"
echo "You can now access your installation via the web interface on http://homeassistant.local:8123"
echo "If that address doesn’t work, you may also try http://localhost:8123 or http://X.X.X.X:8123 (replace X.X.X.X with your Raspberry Pi's IP address)."
echo "Please be patient during the first run as it may take a few minutes to download and install dependencies."
