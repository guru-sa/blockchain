#!/bin/bash
SCRIPT=`realpath -s $0`
SCRIPTPATH=`dirname ${SCRIPT}`
SCRIPTNAME=`basename ${SCRIPT}`
cd ${SCRIPTPATH}

. envVar.sh
. utils.sh

CHANNEL_NAME=${1:-"mychannel"}
VERBOSE=${2:-false}
DELAY=${3:-"3"}
MAX_RETRY=${4:-"5"}

FABRIC_CFG_PATH=${TEST_NETWORK_HOME}/scripts/config

if [ ! -d ${CHANNEL_ARTIFACTS} ]; then
  mkdir ${CHANNEL_ARTIFACTS}
fi

BLOCKFILE=${CHANNEL_ARTIFACTS}/${CHANNEL_NAME}.block

createChannel() {
	setGlobals 1
	# Poll in case the raft leader is not set yet
	local rc=1
	local COUNTER=1
	while [ $rc -ne 0 -a $COUNTER -lt $MAX_RETRY ] ; do
		sleep $DELAY
		set -x
		osnadmin channel join --channelID ${CHANNEL_NAME} --config-block ${CHANNEL_ARTIFACTS}/${CHANNEL_NAME}.block -o localhost:7053 --ca-file "$ORDERER_CA" --client-cert "$ORDERER_ADMIN_TLS_SIGN_CERT" --client-key "$ORDERER_ADMIN_TLS_PRIVATE_KEY" >&log.txt
		res=$?
		{ set +x; } 2>/dev/null
		let rc=$res
		COUNTER=$(expr $COUNTER + 1)
	done
	cat log.txt
	verifyResult $res "Channel creation failed"
}
## Create channel
infoln "Creating channel ${CHANNEL_NAME}"
createChannel
successln "Channel '$CHANNEL_NAME' created"