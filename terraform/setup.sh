#!/bin/bash
set -e

# Update package database
apt-get update

# Install Docker and Docker Compose
apt-get install -y docker.io docker-compose

# Start Docker and ensure it runs on system boot
systemctl enable --now docker

# Give the default 'ubuntu' user permission to run Docker without sudo
usermod -aG docker ubuntu

echo "Docker installation completed successfully!"
