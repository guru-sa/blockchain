#!/bin/bash
SCRIPT=`realpath -s $0`
SCRIPTPATH=`dirname ${SCRIPT}`
SCRIPTNAME=`basename ${SCRIPT}`
cd ${SCRIPTPATH}

ORG=${1:-"Org3"}
DOMAIN=${2:-"org3.example.com"}
VERBOSE=${3:-false}

export FABRIC_CFG_PATH=${TEST_NETWORK_HOME}/scripts/addOrg
export VERBOSE=${VERBOSE}

. utils.sh

# Generate channel configuration transaction
function generateOrg3Definition() {
  which configtxgen
  if [ "$?" -ne 0 ]; then
    fatalln "configtxgen tool not found. exiting"
  fi
  infoln "Generating Org3 organization definition"
  set -x
  configtxgen -printOrg ${ORG}MSP > ${TEST_NETWORK_HOME}/organizations/peerOrganizations/${DOMAIN}/${ORG}.json
  res=$?
  { set +x; } 2>/dev/null
  if [ $res -ne 0 ]; then
    fatalln "Failed to generate Org3 organization definition..."
  fi
}
generateOrg3Definition

