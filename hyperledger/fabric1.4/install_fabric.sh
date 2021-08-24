GOLANG=go1.10.4.linux-amd64.tar.gz
if [ ! -e $GOLANG ]; then
   wget https://storage.googleapis.com/golang/$GOLANG
fi
sudo tar -C /usr/local -xzf $GOLANG
sudo ln -s /usr/local/go/bin/go /usr/bin/go
GOPATH=/opt/gopath
if [ ! -d $GOPATH ]; then
   sudo mkdir $GOPATH
   sudo chown $USER:$USER $GOPATH
fi
echo 'export GOROOT=/usr/local/go' >> ~/.profile
echo 'export GOPATH=/opt/gopath' >> ~/.profile
echo 'export PATH=$PATH:$GOROOT/bin' >> ~/.profile
source ~/.profile

DOCKER=docker-ce_17.06.2~ce-0~ubuntu_amd64.deb
if [ ! -e $DOCKER ]; then
   wget https://download.docker.com/linux/ubuntu/dists/xenial/pool/stable/amd64/$DOCKER
fi
sudo dpkg -i $DOCKER
sudo usermod -a -G docker $USER

DOCKER_COMPOSE=/usr/local/bin/docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o $DOCKER_COMPOSE
sudo chmod +x $DOCKER_COMPOSE
sudo ln -s $DOCKER_COMPOSE /usr/bin/docker-compose

mkdir -p $GOPATH/src/github.com/hyperledger
cd $GOPATH/src/github.com/hyperledger
git clone -b release-1.3 https://github.com/hyperledger/fabric

echo 'export FABRIC_HOME=$GOPATH/src/github.com/hyperledger/fabric' >> ~/.profile
echo 'export PATH=$PATH:$FABRIC_HOME/.build/bin' >> ~/.profile
source ~/.profile

cd $FABRIC_HOME
make

cp $FABRIC_HOME/sampleconfig/core.yaml .
cp $FABRIC_HOME/sampleconfig/orderer.yaml .
echo 'export FABRIC_CFG_PATH=$HOME/fabric1.3' >> ~/.profile
source ~/.profile
