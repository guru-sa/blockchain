#!/bin/bash

if [ "${TEST_NETWORK_HOME}" == "" ]; then
  . scripts/utils.sh
  export TEST_NETWORK_HOME=${PWD}
else
  . utils.sh
fi

export FABRIC_CA_SERVER_HOME=${TEST_NETWORK_HOME}/organizations/fabric-ca
export ORDERER_ORGS=ordererOrganizations
export PEER_ORGS=peerOrganizations
export CHANNEL_ARTIFACTS=${TEST_NETWORK_HOME}/channel-artifacts
export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=${TEST_NETWORK_HOME}/organizations/ordererOrganizations/seogang.com/tlsca/tlsca.seogang.com-cert.pem
export PEER0_ORG1_CA=${TEST_NETWORK_HOME}/organizations/peerOrganizations/org1.seogang.com/peers/peer0.org1.seogang.com/tls/ca.crt
export PEER0_ORG2_CA=${TEST_NETWORK_HOME}/organizations/peerOrganizations/org2.seogang.com/peers/peer0.org2.seogang.com/tls/ca.crt
export PEER0_ORG3_CA=${TEST_NETWORK_HOME}/organizations/peerOrganizations/org3.seogang.com/peers/peer0.org3.seogang.com/tls/ca.crt
export ORDERER_ADMIN_TLS_SIGN_CERT=${TEST_NETWORK_HOME}/organizations/ordererOrganizations/seogang.com/orderers/orderer.seogang.com/tls/server.crt
export ORDERER_ADMIN_TLS_PRIVATE_KEY=${TEST_NETWORK_HOME}/organizations/ordererOrganizations/seogang.com/orderers/orderer.seogang.com/tls/server.key
export CC_SRC_PATH=${TEST_NETWORK_HOME}/chaincode

# Set environment variables for the peer org
setGlobals() {
  local USING_ORG=""
  if [ -z "$OVERRIDE_ORG" ]; then
    USING_ORG=$1
  else
    USING_ORG="${OVERRIDE_ORG}"
  fi
  infoln "Using organization ${USING_ORG}"
  if [ $USING_ORG -eq 1 ]; then
    export CORE_PEER_LOCALMSPID="Org1MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG1_CA
    export CORE_PEER_MSPCONFIGPATH=${TEST_NETWORK_HOME}/organizations/peerOrganizations/org1.seogang.com/users/org1admin@org1.seogang.com/msp
    export CORE_PEER_ADDRESS=localhost:7051
  elif [ $USING_ORG -eq 2 ]; then
    export CORE_PEER_LOCALMSPID="Org2MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG2_CA
    export CORE_PEER_MSPCONFIGPATH=${TEST_NETWORK_HOME}/organizations/peerOrganizations/org2.seogang.com/users/org2admin@org2.seogang.com/msp
    export CORE_PEER_ADDRESS=localhost:9051

  elif [ $USING_ORG -eq 3 ]; then
    export CORE_PEER_LOCALMSPID="Org3MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG3_CA
    export CORE_PEER_MSPCONFIGPATH=${TEST_NETWORK_HOME}/organizations/peerOrganizations/org3.seogang.com/users/org3admin@org3.seogang.com/msp
    export CORE_PEER_ADDRESS=localhost:11051
  else
    errorln "ORG Unknown"
  fi

  if [ "$VERBOSE" == "true" ]; then
    env | grep CORE
  fi
}

# Set environment variables for use in the CLI container 
setGlobalsCLI() {
  setGlobals $1

  local USING_ORG=""
  if [ -z "$OVERRIDE_ORG" ]; then
    USING_ORG=$1
  else
    USING_ORG="${OVERRIDE_ORG}"
  fi
  if [ $USING_ORG -eq 1 ]; then
    export CORE_PEER_ADDRESS=peer0.org1.seogang.com:7051
  elif [ $USING_ORG -eq 2 ]; then
    export CORE_PEER_ADDRESS=peer0.org2.seogang.com:9051
  elif [ $USING_ORG -eq 3 ]; then
    export CORE_PEER_ADDRESS=peer0.org3.seogang.com:11051
  else
    errorln "ORG Unknown"
  fi
}

# parsePeerConnectionParameters $@
# Helper function that sets the peer connection parameters for a chaincode
# operation
parsePeerConnectionParameters() {
  PEER_CONN_PARMS=()
  PEERS=""
  while [ "$#" -gt 0 ]; do
    setGlobals $1
    PEER="peer0.org$1"
    ## Set peer addresses
    if [ -z "$PEERS" ]
    then
	PEERS="$PEER"
    else
	PEERS="$PEERS $PEER"
    fi
    PEER_CONN_PARMS=("${PEER_CONN_PARMS[@]}" --peerAddresses $CORE_PEER_ADDRESS)
    ## Set path to TLS certificate
    CA=PEER0_ORG$1_CA
    TLSINFO=(--tlsRootCertFiles "${!CA}")
    PEER_CONN_PARMS=("${PEER_CONN_PARMS[@]}" "${TLSINFO[@]}")
    # shift by one to get to the next organization
    shift
  done
}

verifyResult() {
  if [ $1 -ne 0 ]; then
    fatalln "$2"
  fi
}
