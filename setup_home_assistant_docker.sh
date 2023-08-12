#!/bin/bash

# Function to check if a command is available
command_exists() {
    command -v "$1" &>/dev/null
}


chmod +x setup_docker_compose.sh
./setup_docker_compose.sh

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

    echo "RESTART HERE"

    chmod +x setup_home_assistant_docker_config.sh
    ./setup_home_assistant_docker_config.sh
fi

