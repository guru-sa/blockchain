#!/bin/bash
SCRIPT=`realpath -s $0`
SCRIPTPATH=`dirname ${SCRIPT}`
SCRIPTNAME=`basename ${SCRIPT}`
cd ${SCRIPTPATH}

source utils.sh

. envVar.sh

CHANNEL_NAME=${1:-"mychannel"}
CC_NAME=${2:-"abstore"}
CC_INIT_FCN=${3:-"NA"}
CC_ARGS=${4:-""}
DELAY=${5:-"3"}
MAX_RETRY=${6:-"5"}
VERBOSE=${7:-"false"}

export FABRIC_CFG_PATH=${TEST_NETWORK_HOME}/scripts/config

println "executing with the following"
println "- CHANNEL_NAME: ${C_GREEN}${CHANNEL_NAME}${C_RESET}"
println "- CC_NAME: ${C_GREEN}${CC_NAME}${C_RESET}"
println "- CC_SRC_PATH: ${C_GREEN}${CC_SRC_PATH}${C_RESET}"
println "- CC_SRC_LANGUAGE: ${C_GREEN}${CC_SRC_LANGUAGE}${C_RESET}"
println "- CC_VERSION: ${C_GREEN}${CC_VERSION}${C_RESET}"
println "- CC_SEQUENCE: ${C_GREEN}${CC_SEQUENCE}${C_RESET}"
println "- CC_INIT_FCN: ${C_GREEN}${CC_INIT_FCN}${C_RESET}"
println "- DELAY: ${C_GREEN}${DELAY}${C_RESET}"
println "- MAX_RETRY: ${C_GREEN}${MAX_RETRY}${C_RESET}"
println "- VERBOSE: ${C_GREEN}${VERBOSE}${C_RESET}"

chaincodeInvokeInit() {
  parsePeerConnectionParameters $@
  res=$?
  verifyResult $res "Invoke transaction failed on channel '$CHANNEL_NAME' due to uneven number of peer and org parameters "

  # while 'peer chaincode' command can get the orderer endpoint from the
  # peer (if join was successful), let's supply it directly as we know
  # it using the "-o" option
  set -x
  fcn_call='{"function":"'${CC_INIT_FCN}'","Args":['${CC_ARGS}']}'
  infoln "invoke fcn call:${fcn_call}"
  peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.seogang.com --tls --cafile "$ORDERER_CA" -C $CHANNEL_NAME -n ${CC_NAME} "${PEER_CONN_PARMS[@]}" -c ${fcn_call} >&log.txt  res=$?
  { set +x; } 2>/dev/null
  cat log.txt
  verifyResult $res "Invoke execution on $PEERS failed "
  successln "Invoke transaction successful on $PEERS on channel '$CHANNEL_NAME'"
}

chaincodeInvokeInit 1 2 3

exit 0
