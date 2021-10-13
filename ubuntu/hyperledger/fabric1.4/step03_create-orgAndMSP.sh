# fabric-ca-client affiliation list 
# fabric-ca-client affiliation remove --force [organization]
# fabric-ca-client affiliation add [organization]
# Start ICA 
# fabric-ca-server start 
#   -b admin:adminpw 
#   -u http://Admin@org1.mandarin.com:org1.mandarin.compassword@192.168.56.109:7054
#   --cfg.affiliations.allowremove --cfg.identities.allowremove -d
# mkdir -p $HOME/fabric1.3/ICA0-cert
# cd $HOME/fabric1.3
# fabric-ca-client enroll -u http://admin:adminpw@192.168.56.109:7054 -H $HOME/fabric1.3/ICA0-cert/
fabric-ca-client affiliation add org1.mandarin.com

mkdir -p $HOME/fabric1.3/crypto-config/peerOrganizations/org1.mandarin.com/msp

fabric-ca-client getcacert 
   -u http://192.168.56.109:7054 
   -M $HOME/fabric1.3/crypto-config/peerOrganizations/org1.mandarin.com/msp

mv $HOME/fabric1.3/crypto-config/peerOrganizations/org1.mandarin.com/msp/cacerts/192-168-56-109-7054.pem \
   $HOME/fabric1.3/crypto-config/peerOrganizations/org1.mandarin.com/msp/cacerts/ca.crt