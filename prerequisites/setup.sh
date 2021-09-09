#!/bin/bash
SCRIPT=`realpath -s $0`
SCRIPTPATH=`dirname ${SCRIPT}`
SCRIPTNAME=`basename ${SCRIPT}`
cd ${SCRIPTPATH}

verifyResuLt() {
  if [ "${1}" -ne "0" ]; then
    exit 1
  fi
}

. ~/.bashrc
set -x
sudo apt-get update
verifyResuLt $?
sudo apt-get install -y --no-install-recommends apt-utils
verifyResuLt $?
sudo apt-get upgrade -y
verifyResuLt $?

# Install Git
sudo apt-get install -y git
verifyResuLt $?

# Install cURL
sudo apt-get install -y curl
verifyResuLt $?

# Docker and Docker Compose
sudo apt-get install -y apt-transport-https
verifyResuLt $?
sudo apt-get install -y ca-certificates
verifyResuLt $?
sudo apt-get install -y software-properties-common
verifyResuLt $?
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
verifyResuLt $?
sudo add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"
verifyResuLt $?
sudo apt-get update
verifyResuLt $?
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
verifyResuLt $?
sudo usermod -aG docker $USER
verifyResuLt $?
sudo systemctl start docker
verifyResuLt $?
sudo systemctl enable docker
verifyResuLt $?
sudo curl -L https://github.com/docker/compose/releases/download/1.29.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
verifyResult $?
chmod +x /usr/local/bin/docker-compose
verifyResuLt $?

# Install Go Programming Language
GO_VER=1.16.7
GO_URL=https://storage.googleapis.com/golang/go${GO_VER}.linux-amd64.tar.gz
verifyResuLt $?
export GOROOT="/opt/go"
export GOPATH="/opt/gopath"
PATH=$GOROOT/bin:$GOPATH/bin:$PATH

cat <<EOF >/etc/profile.d/goroot.sh
export GOROOT=$GOROOT
export GOPATH=$GOPATH
export PATH=\$PATH:$GOROOT/bin:$GOPATH/bin
EOF

mkdir -p $GOROOT
curl -sL $GO_URL | (cd $GOROOT && tar --strip-components 1 -xz)
verifyResuLt $?

mkdir -p ~/gopath/src/github.com
sudo ln -s ~/gopath /opt/gopath

# Install Node.js Runtime and NPM"

if [ ! -d ~/.nvm ]; then
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  nvm install v8.9.4
  nvm install v10.15.3
  nvm alias default v8.9.4
fi

# Install for build 
sudo apt-get install -y gcc
sudo apt-get install -y make

# Install others
sudo apt-get install -y dnsutils
sudo apt-get install -y iputils-ping
sudo apt-get install -y jq
sudo apt-get install -y net-tools
sudo apt-get install -y netcat
sudo apt-get install -y ntp
sudo apt-get install -y openssh-server
sudo apt-get install -y subversion
sudo apt-get install -y telnet
sudo apt-get install -y tree
sudo apt-get install -y vim

exit 0
