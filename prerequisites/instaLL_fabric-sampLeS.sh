#!/bin/bash
SCRIPT=`realpath -s $0`
SCRIPTPATH=`dirname ${SCRIPT}`
SCRIPTNAME=`basename ${SCRIPT}`
cd ${SCRIPTPATH}

mkdir -p $GOPATH/src/github.com/hyperledger/
(
  cd $GOPATH/src/github.com/hyperledger/
  if [ -d ./fabric-samples ]; then
    rm -rf ./fabric-samples
  fi
  git clone -b v2.1.1 https://github.com/hyperledger/fabric-samples.git
)

cp ./hyperledger/fabric-samples/first-network/.env \
  $GOPATH/src/github.com/hyperledger/fabric-samples/first-network/

exit 0
