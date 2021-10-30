#!/bin/bash
SCRIPT=`realpath -s $0`
SCRIPTPATH=`dirname ${SCRIPT}`
SCRIPTNAME=`basename ${SCRIPT}`
cd ${SCRIPTPATH}
set -x

mkdir -p ~/gopath/src/github.com
sudo ln -s ~/gopath /opt/gopath

mkdir -p $GOPATH/src/github.com/hyperledger/
(
  cd $GOPATH/src/github.com/hyperledger/
  if [ -d ./fabric ]; then
    rm -rf ./fabric
  fi
  git clone https://github.com/hyperledger/fabric.git
  (
    cd ./fabric
    git checkout tags/v2.3.3
    make native
    mkdir -p ${SCRIPTPATH}/bin/
    cp ./build/bin/* ${SCRIPTPATH}/bin/
    export TEST_NETWORK_HOME=${SCRIPTPATH}/test-network
    echo "export TEST_NETWORK_HOME=${TEST_NETWORK_HOME}" >> ~/.bashrc
    echo "export PATH=${SCRIPTPATH}/bin:$PATH" >> ~/.bashrc
  )
)

exit 0
