ORDERER_GENERAL_LOGLEVEL=info \
ORDERER_GENERAL_LISTENADDRESS=orderer.mandarin.com \
ORDERER_GENERAL_GENESISMETHOD=file \
ORDERER_GENERAL_GENESISFILE=${FABRIC_CFG_PATH}/crypto-config/ordererOrganizations/mandarin.com/orderers/orderer.mandarin.com/genesis.block \
ORDERER_GENERAL_LOCALMSPID=OrdererMSP \
ORDERER_GENERAL_LOCALMSPDIR=${FABRIC_CFG_PATH}/crypto-config/ordererOrganizations/mandarin.com/orderers/orderer.mandarin.com/msp \
ORDERER_GENERAL_TLS_ENABLED=false \
ORDERER_GENERAL_TLS_PRIVATEKEY=${FABRIC_CFG_PATH}/crypto-config/ordererOrganizations/mandarin.com/orderers/orderer.mandarin.com/tls/server.key \
ORDERER_GENERAL_TLS_CERTIFICATE=${FABRIC_CFG_PATH}/crypto-config/ordererOrganizations/mandarin.com/orderers/orderer.mandarin.com/tls/server.crt \
ORDERER_GENERAL_TLS_ROOTCAS=[${FABRIC_CFG_PATH}/crypto-config/ordererOrganizations/mandarin.com/orderers/orderer.mandarin.com/tls/ca/crt,${FABRIC_CFG_PATH}/crypto-config/peerOrganizations/org1.mandarin.com/peers/peer0.org1.mandarin.com/tls/ca.crt] \
CONFIGTX_ORDERER_BATCHTIMEOUT=1s \
CONFIGTX_ORDERER_ORDERERTYPE=solo \
orderer start &

