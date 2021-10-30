#!/bin/bash
SCRIPT=`realpath -s $0`
SCRIPTPATH=`dirname ${SCRIPT}`
SCRIPTNAME=`basename ${SCRIPT}`
cd ${SCRIPTPATH}

. envVar.sh
. utils.sh

CHANNEL_NAME=${1:-"mychannel"}
export FABRIC_CFG_PATH=${TEST_NETWORK_HOME}/scripts/config

if [ ! -d ${CHANNEL_ARTIFACTS} ]; then
  mkdir ${CHANNEL_ARTIFACTS}
fi

which configtxgen
if [ "$?" -ne 0 ]; then
  fatalln "configtxgen tool not found."
  exit 1
fi
infoln "Generating channel genesis block '${CHANNEL_NAME}.block'"
set -x
configtxgen -profile TwoOrgsApplicationGenesis -outputBlock ${CHANNEL_ARTIFACTS}/${CHANNEL_NAME}.block -channelID ${CHANNEL_NAME}
res=$?
{ set +x; } 2>/dev/null
verifyResult $res "Failed to generate channel configuration transaction..."
