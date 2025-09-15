# Docker Installation Guide for Ubuntu and RHEL

This guide provides step-by-step commands to install Docker on Ubuntu and RHEL-based systems.

---

## 1. Docker Installation on Ubuntu

```bash
# Update package index
apt update -y

# Install dependencies
apt install -y ca-certificates curl gnupg lsb-release

# Add Docker GPG key
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

# Add Docker repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine, CLI, and Compose
apt update -y
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Enable and start Docker
systemctl enable docker
systemctl start docker

# Add current user to docker group (optional)
usermod -aG docker $USER

# Verify Docker
docker --version
docker run hello-world
```

---

## 2. Docker Installation on RHEL (8/9, CentOS, Rocky, AlmaLinux)

```bash
# Remove old Docker versions (if any)
dnf remove -y docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine || true

# Install dependencies
dnf install -y yum-utils device-mapper-persistent-data lvm2

# Add Docker repository
yum-config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo

# Install Docker Engine, CLI, and Compose
dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Enable and start Docker
systemctl enable docker
systemctl start docker

# Add current user to docker group (optional)
usermod -aG docker $USER

# Verify Docker
docker --version
docker run hello-world
```


---

## RHEL, CENTOS, ROCKEY LINUXY.

```bash
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker $(whoami)
sudo usermod -aG docker root
sudo systemctl start docker
sudo docker -v  
  

# Docker-compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version
```

---

**Note:** Logout and log back in (or run `newgrp docker`) after adding your user to the Docker group to run Docker without `sudo`.