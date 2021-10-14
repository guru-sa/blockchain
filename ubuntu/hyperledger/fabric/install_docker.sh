# Uninstall old versions
sudo apt-get remove -y docker docker-engine docker.io containerd runc

# Setup the repositories
sudo apt-get update
sudo apt-get install -y apt-transport-https
sudo apt-get install -y ca-certificates
sudo apt-get install -y curl
sudo apt-get install -y gnupg-agent
sudo apt-get install -y software-properties-common

# Add docker's official GPG(GNU Privacy Guard) key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Check
sudo apt-key fingerprint 0EBFCD88

# Setup the stable release repository
sudo add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"

# Install docker
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Verify docker engine
sudo docker run hello-world
  
# Add super user
sudo usermod -aG docker ${USER}
su - ${USER}

# Check docker daemon status
sudo systemctl status docker




