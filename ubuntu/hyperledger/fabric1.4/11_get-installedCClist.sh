export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_MSPCONFIGPATH=${FABRIC_CFG_PATH}/crypto-config/peerOrganizations/org1.mandarin.com/users/Admin@org1.mandarin.com/msp
export CORE_PEER_ADDRESS=peer0.org1.mandarin.com:7051
peer chaincode list -C channel --installed