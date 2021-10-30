#!/bin/bash
#
# Copyright IBM Corp. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0
#

# This script is designed to be run in the cli container as the
# first step of the EYFN tutorial.  It creates and submits a
# configuration transaction to add org3 to the test network
#

ORG=${1:-"3"}
CHANNEL_NAME=${2:-"mychannel"}
DOMAIN=${3:-"org3.example.com"}
DELAY=${4:-"3"}
TIMEOUT=${5:-"10"}
VERBOSE=${6:-false}

COUNTER=1
MAX_RETRY=5

# imports
. scripts/envVar.sh

export FABRIC_CFG_PATH=${TEST_NETWORK_HOME}/scripts/config

# fetchChannelConfig <org> <channel_id> <output_json>
# Writes the current channel config for a given channel to a JSON file
# NOTE: this must be run in a CLI container since it requires configtxlator 
fetchChannelConfig() {
  CHANNEL=$2
  OUTPUT=$3

  setGlobals $1

  infoln "Fetching the most recent configuration block for the channel"
  set -x
  peer channel fetch config config_block.pb -o orderer.example.com:7050 --ordererTLSHostnameOverride orderer.example.com -c $CHANNEL --tls --cafile "$ORDERER_CA"
  { set +x; } 2>/dev/null

  infoln "Decoding config block to JSON and isolating config to ${OUTPUT}"
  set -x
  configtxlator proto_decode --input config_block.pb --type common.Block | jq .data.data[0].payload.data.config >"${OUTPUT}"
  { set +x; } 2>/dev/null
}

infoln "Fetching channel config for channel $CHANNEL_NAME"
fetchChannelConfig 1 $CHANNEL_NAME config.json

# Modify the configuration to append the new org
set -x
jq -s '.[0] * {"channel_group":{"groups":{"Application":{"groups": {"Org'${ORG}'MSP":.[1]}}}}}' config.json ${TEST_NETWORK_HOME}/organizations/peerOrganizations/${DOMAIN}/Org${ORG}.json > modified_config.json
{ set +x; } 2>/dev/null

# Compute a config update, based on the differences between config.json and modified_config.json, write it as a transaction to org3_update_in_envelope.pb
CHANNEL=${CHANNEL_NAME}
ORIGINAL=config.json
MODIFIED=modified_config.json
OUTPUT=org3_update_in_envelope.pb
set -x
configtxlator proto_encode --input "${ORIGINAL}" --type common.Config >original_config.pb
configtxlator proto_encode --input "${MODIFIED}" --type common.Config >modified_config.pb
configtxlator compute_update --channel_id "${CHANNEL}" --original original_config.pb --updated modified_config.pb >config_update.pb
configtxlator proto_decode --input config_update.pb --type common.ConfigUpdate >config_update.json
echo '{"payload":{"header":{"channel_header":{"channel_id":"'$CHANNEL'", "type":2}},"data":{"config_update":'$(cat config_update.json)'}}}' | jq . >config_update_in_envelope.json
configtxlator proto_encode --input config_update_in_envelope.json --type common.Envelope >"${OUTPUT}"
{ set +x; } 2>/dev/null

infoln "Signing config transaction"
setGlobals 1
set -x
peer channel signconfigtx -f "${OUTPUT}"
{ set +x; } 2>/dev/null

infoln "Submitting transaction from a different peer (peer0.org2) which also signs it"
setGlobals 2
set -x
peer channel update -f ${OUTPUT} -c ${CHANNEL_NAME} -o orderer.example.com:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "$ORDERER_CA"
{ set +x; } 2>/dev/null

successln "Config transaction to add org3 to network submitted"
