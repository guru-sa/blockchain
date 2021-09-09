#!/bin/bash
SCRIPT=`realpath -s $0`
SCRIPTPATH=`dirname ${SCRIPT}`
SCRIPTNAME=`basename ${SCRIPT}`
cd ${SCRIPTPATH}
set -x
mkdir -p $GOPATH/src/github.com/hyperledger/
(
  cd $GOPATH/src/github.com/hyperledger/
  if [ -d ./fabric ]; then
    rm -rf ./fabric
  fi
  git clone https://github.com/hyperledger/fabric.git
  (
    cd ./fabric
    git checkout tags/v2.2.3
    #make configtxgen
    #make configtxlator
    #make cryptogen
    #make idemixgen
    #make peer
    #make orderer
    make native
    mkdir -p ${SCRIPTPATH}/hyperledger/bin/
    cp ./build/bin/* ${SCRIPTPATH}/hyperledger/bin/
  )
)

exit 0
