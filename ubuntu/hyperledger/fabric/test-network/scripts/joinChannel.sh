#!/bin/bash
SCRIPT=`realpath -s $0`
SCRIPTPATH=`dirname ${SCRIPT}`
SCRIPTNAME=`basename ${SCRIPT}`
cd ${SCRIPTPATH}

. envVar.sh
. utils.sh

CHANNEL_NAME=${1:-"mychannel"}
ORG=${2:-"1"}
VERBOSE=${3:-false}
DELAY=${4:-"3"}
MAX_RETRY=${5:-"5"}

export FABRIC_CFG_PATH=${TEST_NETWORK_HOME}/scripts/config

if [ ! -d ${CHANNEL_ARTIFACTS} ]; then
  mkdir ${CHANNEL_ARTIFACTS}
fi

BLOCKFILE=${CHANNEL_ARTIFACTS}/${CHANNEL_NAME}.block

# joinChannel ORG
joinChannel() {
  ORG=$1
  setGlobals $ORG
	local rc=1
	local COUNTER=1
	## Sometimes Join takes time, hence retry
	while [ $rc -ne 0 -a $COUNTER -lt $MAX_RETRY ] ; do
    sleep $DELAY
    set -x
    peer channel join -b $BLOCKFILE >&log.txt
    res=$?
    { set +x; } 2>/dev/null
		let rc=$res
		COUNTER=$(expr $COUNTER + 1)
	done
	cat log.txt
	verifyResult $res "After $MAX_RETRY attempts, peer0.org${ORG} has failed to join channel '$CHANNEL_NAME' "
}
## Join all the peers to the channel
infoln "Joining org${ORG} peer to the channel..."
joinChannel ${ORG}