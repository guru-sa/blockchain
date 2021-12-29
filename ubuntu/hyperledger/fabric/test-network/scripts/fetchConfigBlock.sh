#!/bin/bash

. scripts/envVar.sh

ORG=${1:-"3"}
CHANNEL_NAME=${2:-"mychannel"}
VERBOSE=${3:-false}

export FABRIC_CFG_PATH=${TEST_NETWORK_HOME}/scripts/config
setGlobalsCLI ${ORG}

if [ ! -d ${CHANNEL_ARTIFACTS} ]; then
  mkdir ${CHANNEL_ARTIFACTS}
fi

BLOCKFILE=${CHANNEL_ARTIFACTS}/${CHANNEL_NAME}.block

echo "Fetching channel config block from orderer..."
set -x
peer channel fetch 0 $BLOCKFILE -o orderer.seogang.com:7050 --ordererTLSHostnameOverride orderer.seogang.com -c $CHANNEL_NAME --tls --cafile "$ORDERER_CA" >&log.txt
res=$?
{ set +x; } 2>/dev/null
cat log.txt
verifyResult $res "Fetching config block from orderer has failed"