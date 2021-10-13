#!/bin/bash
SCRIPT=`realpath -s $0`
SCRIPTPATH=`dirname ${SCRIPT}`
SCRIPTNAME=`basename ${SCRIPT}`
cd ${SCRIPTPATH}

dpkg -l | grep " libltdl-dev " > /dev/null
if [ $? -ne 0 ]; then
  sudo apt-get install -y libltdl-dev
fi

mkdir -p $GOPATH/src/github.com/hyperledger/
(
  cd $GOPATH/src/github.com/hyperledger/
  if [ -d ./fabric-ca ]; then
    rm -rf ./fabric-ca
  fi
  git clone https://github.com/hyperledger/fabric-ca.git
  (
    cd ./fabric-ca
    git checkout tags/v2.0.0-alpha
    make fabric-ca-server
    make fabric-ca-client
    mkdir -p ${SCRIPTPATH}/hyperledger/bin/
    cp ./bin/fabric-ca-server ${SCRIPTPATH}/hyperledger/bin/
    cp ./bin/fabric-ca-client ${SCRIPTPATH}/hyperledger/bin/
  )
)

exit 0
