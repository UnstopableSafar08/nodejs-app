#!/bin/bash
# Detects whether you are on Ubuntu/Debian or RHEL-based system.
# Installs Docker, enables and starts the service.
# Adds current user to the docker group.
# Verifies installation by running docker --version and docker run hello-world.
# Install Docker on Ubuntu or RHEL (8/9, Rocky, AlmaLinux)

set -e

if [ -f /etc/debian_version ]; then
    echo "Detected Ubuntu/Debian - Installing Docker..."

    apt update -y
    apt install -y ca-certificates curl gnupg lsb-release

    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    chmod a+r /etc/apt/keyrings/docker.gpg

    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

    apt update -y
    apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    systemctl enable docker
    systemctl start docker

    usermod -aG docker $USER
    echo "Docker installed successfully on Ubuntu. Logout & login again or run: newgrp docker"

elif [ -f /etc/redhat-release ]; then
    echo "Detected RHEL/CentOS/Rocky/AlmaLinux - Installing Docker..."

    dnf remove -y docker docker-client docker-client-latest docker-common docker-latest \
       docker-latest-logrotate docker-logrotate docker-engine || true

    dnf install -y yum-utils device-mapper-persistent-data lvm2
    yum-config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo

    dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    systemctl enable docker
    systemctl start docker

    usermod -aG docker $USER
    echo "Docker installed successfully on RHEL-based system. Logout & login again or run: newgrp docker"

else
    echo "Unsupported OS. Please install Docker manually."
    exit 1
fi

# Verify installation
docker --version
docker run hello-world
