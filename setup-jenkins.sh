#!/bin/bash

# Ensure Docker is running
sudo systemctl start docker

# Pull the Jenkins Docker image
docker pull jenkins/jenkins:lts

# Create Jenkins home directory
sudo mkdir -p /var/jenkins_home

# Run Jenkins container on a different port
docker run -d -p 5000:8080 \
    --name jenkins-container \
    jenkins/jenkins:lts

# Display Jenkins initial admin password
echo "Jenkins is running. Retrieve the admin password using the following command:"
echo "docker exec jenkins-container cat /var/jenkins_home/secrets/initialAdminPassword"
