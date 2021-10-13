# run peer

# peer0
CORE_PEER_ENDORSER_ENABLED=true \
CORE_PEER_ADDRESS=peer0.org1.mandarin.com:7051 \
CORE_PEER_CHAINCODELISTENADDRESS=peer0.org1.mandarin.com:7052 \
CORE_PEER_ID=peer0.org1.mandarin.com \
CORE_PEER_LOCALMSPID=Org1MSP \
CORE_PEER_GOSSIP_EXTERNALENDPOINT=peer0.org1.mandarin.com:7051 \
CORE_PEER_GOSSIP_USELEADERELECTION=true \
CORE_PEER_GOSSIP_ORGLEADER=false \
CORE_PEER_TLS_ENABLED=false \
CORE_PEER_TLS_KEY_FILE=${FABRIC_CFG_PATH}/crypto-config/peerOrganizations/org1.mandarin.com/peers/peer0.org1.mandarin.com/tls/server.key \
CORE_PEER_TLS_CERT_FILE=${FABRIC_CFG_PATH}/crypto-config/peerOrganizations/org1.mandarin.com/peers/peer0.org1.mandarin.com/tls/server.crt \
CORE_PEER_TLS_ROOT_FILE=${FABRIC_CFG_PATH}/crypto-config/peerOrganizations/org1.mandarin.com/peers/peer0.org1.mandarin.com/tls/ca.crt \
CORE_PEER_TLS_SERVERHOSTOVERRIDE=peer0.org1.mandarin.com \
CORE_PEER_MSPCONFIGPATH=${FABRIC_CFG_PATH}/crypto-config/peerOrganizations/org1.mandarin.com/peers/peer0.org1.mandarin.com/msp \
peer node start &
