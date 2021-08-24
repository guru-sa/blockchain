configtxgen -profile TwoOrgsOrdererGenesis -outputBlock genesis.block
mv ./genesis.block ./crypto-config/ordererOrganizations/mandarin.com/orderers/orderer.mandarin.com/
