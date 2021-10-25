#!/bin/bash

# imports  
. scripts/envVar.sh
. scripts/utils.sh

CHANNEL_NAME=${1:-"mychannel"}
FABRIC_CFG_PATH=${PWD}/configtx

export PATH=${PWD}/../bin:$PATH

if [ ! -d "channel-artifacts" ]; then
  mkdir channel-artifacts
fi

which configtxgen
if [ "$?" -ne 0 ]; then
  fatalln "configtxgen tool not found."
fi
infoln "Generating channel genesis block '${CHANNEL_NAME}.block'"
set -x
configtxgen -profile TwoOrgsApplicationGenesis -outputBlock ./channel-artifacts/${CHANNEL_NAME}.block -channelID ${CHANNEL_NAME}
res=$?
{ set +x; } 2>/dev/null
verifyResult $res "Failed to generate channel configuration transaction..."
