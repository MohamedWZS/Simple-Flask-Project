#!/bin/bash

# Function to check if Podman is installed and remove it if so
function check_and_remove_podman() {
    if command -v podman &> /dev/null
    then
        echo "Podman is installed. Removing Podman to avoid conflicts with Docker."

        # Stop Podman service if running
        sudo systemctl stop podman || true

        # Disable Podman from starting automatically
        sudo systemctl disable podman || true

        # Remove Podman
        sudo yum remove -y podman podman-plugins

        echo "Podman has been removed."
    else
        echo "Podman is not installed. Proceeding with Docker installation."
    fi
}

# Function to check and add the user to the docker group
function add_user_to_docker_group() {
    if ! groups $USER | grep -q '\bdocker\b'; then
        echo "Adding current user to the Docker group."
        sudo usermod -aG docker $USER
        echo "User added to Docker group."

        # Prompt user to log out and log back in
        echo "Please log out and log back in to apply Docker group changes, or run 'newgrp docker' to avoid logging out."
        echo "Once done, please run the second script to complete Jenkins setup."
        exit
    else
        echo "User is already in the Docker group."
    fi
}

# Update and install required packages
sudo yum update -y
sudo yum install -y yum-utils device-mapper-persistent-data lvm2

# Check and remove Podman if installed
check_and_remove_podman

# Add Docker repository
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Install Docker
sudo yum install -y docker-ce docker-ce-cli containerd.io

# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Check if the user is part of the docker group, and if not, add them
add_user_to_docker_group

# End script 1, wait for log out/log back in before continuing
echo "Docker setup is complete. Please log out and back in, then run 'setup-jenkins.sh' to continue."
