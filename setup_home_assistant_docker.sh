#!/bin/bash

# Function to check if a command is available
command_exists() {
    command -v "$1" &>/dev/null
}

# Install Docker Compose if not already installed
if ! command_exists docker-compose; then
    echo "Docker Compose is not installed. Installing..."
    sudo curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo rm get-docker.sh

    # Add the current user to the docker group to run docker commands without sudo
    sudo usermod -aG docker "$USER"

    # Log out and log back in for the group changes to take effect
    echo "Please log out and log back in for Docker group changes to take effect."
    exit 1
fi

# Create a directory for the Home Assistant configuration files
CONFIG_DIR="/path/to/your/config"  # Replace this with the desired configuration directory path
if [ ! -d "$CONFIG_DIR" ]; then
    echo "Creating configuration directory..."
    mkdir -p "$CONFIG_DIR"
fi

# Create a docker-compose.yml file if not already exists
if [ ! -f "docker-compose.yml" ]; then
    cat <<EOF >docker-compose.yml
version: '3'
services:
  homeassistant:
    container_name: homeassistant
    image: "ghcr.io/home-assistant/home-assistant:stable"
    volumes:
      - "$CONFIG_DIR:/config"
      - /etc/localtime:/etc/localtime:ro
    restart: unless-stopped
    privileged: true
    network_mode: host
EOF
fi

# Start Home Assistant using Docker Compose if not already running
if ! docker-compose ps | grep -q homeassistant; then
    echo "Starting Home Assistant using Docker Compose..."
    docker-compose up -d
else
    echo "Home Assistant is already running."
fi

echo "Home Assistant is now running. You can access it at http://<hostname>:8123"

# Optional: Expose Zigbee or other devices (add device mapping to your container instructions)
# For example, to expose /dev/ttyUSB0:
# docker-compose up -d --device /dev/ttyUSB0:/dev/ttyUSB0

# Optional: Disable jemalloc for better memory management
# docker-compose up -d -e "DISABLE_JEMALLOC=true"
