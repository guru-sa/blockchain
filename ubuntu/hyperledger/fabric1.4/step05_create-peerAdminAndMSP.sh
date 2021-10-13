fabric-ca-client register --id.secret=peer0.org1.mandarin.compassword
  -H $HOME/fabric1.3/crypto-config/peerOrganizations/org1.mandarin.com/users/Admin@org1.mandarin.com/

mkdir -p $HOME/fabric1.3/crypto-config/peerOrganizations/org1.mandarin.com/peers/peer0.org1.mandarin.com

fabric-ca-client enroll 
   -u http://peer0.org1.mandarin.com@peer0.org1.mandarin.com:peer0.org1.mandarin.compassword@192.168.56.109:7054
   -H $HOME/fabric1.3/crypto-config/peerOrganizations/org1.mandarin.com/peers/peer0.org1.mandarin.com

mv $HOME/fabric1.3/crypto-config/peerOrganizations/org1.mandarin.com/peers/peer0.org1.mandarin.com/msp/cacerts/192-168-56-109-7054.pem \
   $HOME/fabric1.3/crypto-config/peerOrganizations/org1.mandarin.com/peers/peer0.org1.mandarin.com/msp/cacerts/ca.crt
mv $HOME/fabric1.3/crypto-config/peerOrganizations/org1.mandarin.com/peers/peer0.org1.mandarin.com/msp/keystore/${privateKey} \
   $HOME/fabric1.3/crypto-config/peerOrganizations/org1.mandarin.com/peers/peer0.org1.mandarin.com/msp/keystore/server.key

mkdir -p $HOME/fabric1.3/crypto-config/peerOrganizations/org1.mandarin.com/users/Admin@org1.mandarin.com/msp/admincerts

cp $HOME/fabric1.3/crypto-config/peerOrganizations/org1.mandarin.com/users/Admin@org1.mandarin.com/msp/signcerts/cert.pem #publicKey
   $HOME/fabric1.3/crypto-config/peerOrganizations/org1.mandarin.com/users/Admin@org1.mandarin.com/msp/admincerts/Admin@org1.mandarin.com-cert.pem 

