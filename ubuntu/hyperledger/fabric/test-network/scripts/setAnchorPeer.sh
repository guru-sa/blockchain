#!/bin/bash

. scripts/envVar.sh

ORG=${1:-1}
CHANNEL_NAME=${2:-"mychannel"}

setGlobalsCLI $ORG
setGlobals $ORG

export FABRIC_CFG_PATH=${TEST_NETWORK_HOME}/scripts/config

# fetchChannelConfig <org> <channel_id> <output_json>
# Writes the current channel config for a given channel to a JSON file
# NOTE: this must be run in a CLI container since it requires configtxlator 
fetchChannelConfig() {
  ORG=$1
  CHANNEL=$2
  OUTPUT=$3

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
fetchChannelConfig $ORG $CHANNEL_NAME ${CORE_PEER_LOCALMSPID}config.json

infoln "Generating anchor peer update transaction for Org${ORG} on channel $CHANNEL_NAME"

if [ $ORG -eq 1 ]; then
  HOST="peer0.org1.example.com"
  PORT=7051
elif [ $ORG -eq 2 ]; then
  HOST="peer0.org2.example.com"
  PORT=9051
elif [ $ORG -eq 3 ]; then
  HOST="peer0.org3.example.com"
  PORT=11051
else
  errorln "Org${ORG} unknown"
fi

set -x
# Modify the configuration to append the anchor peer 
jq '.channel_group.groups.Application.groups.'${CORE_PEER_LOCALMSPID}'.values += {"AnchorPeers":{"mod_policy": "Admins","value":{"anchor_peers": [{"host": "'$HOST'","port": '$PORT'}]},"version": "0"}}' ${CORE_PEER_LOCALMSPID}config.json > ${CORE_PEER_LOCALMSPID}modified_config.json
{ set +x; } 2>/dev/null
   
CHANNEL=${CHANNEL_NAME}
ORIGINAL=${CORE_PEER_LOCALMSPID}config.json
MODIFIED=${CORE_PEER_LOCALMSPID}modified_config.json
OUTPUT=${CORE_PEER_LOCALMSPID}anchors.tx
set -x
configtxlator proto_encode --input "${ORIGINAL}" --type common.Config >original_config.pb
configtxlator proto_encode --input "${MODIFIED}" --type common.Config >modified_config.pb
configtxlator compute_update --channel_id "${CHANNEL}" --original original_config.pb --updated modified_config.pb >config_update.pb
configtxlator proto_decode --input config_update.pb --type common.ConfigUpdate >config_update.json
echo '{"payload":{"header":{"channel_header":{"channel_id":"'$CHANNEL'", "type":2}},"data":{"config_update":'$(cat config_update.json)'}}}' | jq . >config_update_in_envelope.json
configtxlator proto_encode --input config_update_in_envelope.json --type common.Envelope >"${OUTPUT}"
{ set +x; } 2>/dev/null

peer channel update -o orderer.example.com:7050 --ordererTLSHostnameOverride orderer.example.com -c $CHANNEL -f ${OUTPUT} --tls --cafile "$ORDERER_CA" >&log.txt
res=$?
cat log.txt
verifyResult $res "Anchor peer update failed"
successln "Anchor peer set for org '$CORE_PEER_LOCALMSPID' on channel '$CHANNEL'"