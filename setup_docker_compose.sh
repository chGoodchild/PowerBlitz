#!/bin/bash

# Function to check if a command is available
command_exists() {
    command -v "$1" &>/dev/null
}

# Check if Docker Compose is already installed
if command_exists docker-compose; then
    echo "Docker Compose is already installed."
    exit 0
fi

# Check if Docker Engine is installed
if ! command_exists docker; then
    echo "Docker is not installed. Please install Docker first."
    exit 1
fi

# Check if the system is Ubuntu or Debian
if command_exists apt-get; then
    echo "Installing Docker Compose on Ubuntu/Debian..."
    sudo apt-get update
    sudo apt-get install -y docker-compose
elif command_exists yum; then
    # Check if the system is CentOS or RPM-based
    echo "Installing Docker Compose on CentOS/RPM-based..."
    sudo yum update
    sudo yum install -y docker-compose
else
    echo "Unsupported Linux distribution. Please install Docker Compose manually."
    exit 1
fi

# Verify that Docker Compose is installed correctly
if command_exists docker-compose; then
    echo "Docker Compose installation completed successfully."
else
    echo "Docker Compose installation failed. Please check the logs for errors."
fi
