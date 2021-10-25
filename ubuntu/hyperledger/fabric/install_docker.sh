#!/bin/bash
SCRIPT=`realpath -s $0`
SCRIPTPATH=`dirname ${SCRIPT}`
SCRIPTNAME=`basename ${SCRIPT}`
cd ${SCRIPTPATH}

checkResult() {
  if [ "${1}" -ne "0" ]; then
    exit 1
  fi
}

# Uninstall old versions
sudo apt-get remove -y docker docker-engine docker.io containerd runc
checkResult $?

# Setup the repositories
sudo apt-get update
checkResult $?

sudo apt-get install -y apt-transport-https
checkResult $?

sudo apt-get install -y ca-certificates
checkResult $?

sudo apt-get install -y curl
checkResult $?

sudo apt-get install -y gnupg-agent
checkResult $?

sudo apt-get install -y software-properties-common
checkResult $?

# Add docker's official GPG(GNU Privacy Guard) key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
checkResult $?

# Check
sudo apt-key fingerprint 0EBFCD88
checkResult $?

# Setup the stable release repository
sudo add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"
checkResult $?

# Install docker
sudo apt-get update
checkResult $?

sudo apt-get install -y docker-ce docker-ce-cli containerd.io
checkResult $?

# Verify docker engine
sudo docker run hello-world
checkResult $?

# Add super user
sudo usermod -aG docker ${USER}
checkResult $?

# Check docker daemon status
sudo systemctl status docker
checkResult $?


exit 0
