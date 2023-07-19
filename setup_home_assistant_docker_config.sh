#!/bin/bash

# Create a directory for the Home Assistant configuration files
CONFIG_DIR="/path/to/your/config"  # Replace this with the desired configuration directory path
if [ ! -d "$CONFIG_DIR" ]; then
    echo "Creating configuration directory..."
    sudo mkdir -p "$CONFIG_DIR"
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

sudo systemctl status docker

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
