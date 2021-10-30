#!/bin/bash
SCRIPT=`realpath -s $0`
SCRIPTPATH=`dirname ${SCRIPT}`
SCRIPTNAME=`basename ${SCRIPT}`
cd ${SCRIPTPATH}

scripts/startCA.sh false
sleep 5
scripts/enroll.sh false true "" "" "org1.example.com" "7054" "org1" "ca-org1" "admin"
scripts/register.sh false "org1.example.com" "org1" "ca-org1" "peer0" "peer"
scripts/register.sh false "org1.example.com" "org1" "ca-org1" "user1" "client"
scripts/register.sh false "org1.example.com" "org1" "ca-org1" "org1admin" "admin"
scripts/enroll.sh false false "msp" "host" "org1.example.com" "7054" "org1" "ca-org1" "peer0"
scripts/enroll.sh false false "tls" "" "org1.example.com" "7054" "org1" "ca-org1" "peer0"
scripts/enroll.sh false false "msp" "user" "org1.example.com" "7054" "org1" "ca-org1" "user1"
scripts/enroll.sh false false "msp" "user" "org1.example.com" "7054" "org1" "ca-org1" "org1admin"
./organizations/ccp-generate.sh "1" "7051" "7054" "org1.example.com"

scripts/enroll.sh false true "" "" "org2.example.com" "8054" "org2" "ca-org2" "admin"
scripts/register.sh false "org2.example.com" "org2" "ca-org2" "peer0" "peer"
scripts/register.sh false "org2.example.com" "org2" "ca-org2" "user1" "client"
scripts/register.sh false "org2.example.com" "org2" "ca-org2" "org2admin" "admin"
scripts/enroll.sh false false "msp" "host" "org2.example.com" "8054" "org2" "ca-org2" "peer0"
scripts/enroll.sh false false "tls" "" "org2.example.com" "8054" "org2" "ca-org2" "peer0"
scripts/enroll.sh false false "msp" "user" "org2.example.com" "8054" "org2" "ca-org2" "user1"
scripts/enroll.sh false false "msp" "user" "org2.example.com" "8054" "org2" "ca-org2" "org2admin"
./organizations/ccp-generate.sh "2" "9051" "8054" "org2.example.com"

scripts/enroll.sh true true "" "" "example.com" "9054" "ordererOrg" "ca-orderer" "admin"
scripts/register.sh true "example.com" "ordererOrg" "ca-orderer" "orderer" "orderer"
scripts/register.sh true "example.com" "ordererOrg" "ca-orderer" "ordererAdmin" "admin"
scripts/enroll.sh true false "msp" "host" "example.com" "9054" "ordererOrg" "ca-orderer" "orderer"
scripts/enroll.sh true false "tls" "" "example.com" "9054" "ordererOrg" "ca-orderer" "orderer"
scripts/enroll.sh true false "msp" "user" "example.com" "9054" "ordererOrg" "ca-orderer" "ordererAdmin"

scripts/startNodes.sh false
sleep 5

scripts/createChannelGenesisBlock.sh "mychannel"
sleep 5
scripts/createChannel.sh "mychannel" false "1" "5"
sleep 5
scripts/joinChannel.sh "mychannel" 1 false "1" "5"
sleep 5
scripts/joinChannel.sh "mychannel" 2 false "1" "5"
sleep 5
docker exec cli ./scripts/setAnchorPeer.sh 1 "mychannel"
sleep 5
docker exec cli ./scripts/setAnchorPeer.sh 2 "mychannel"
sleep 5

# scripts/deployCC.sh "mychannel" "abstore" "go" "1.0" "1" "" "" "" "3" "5" "false"

# scripts/startCA.sh true
# sleep 5
# scripts/enroll.sh false true "" "" "org3.example.com" "11054" "org3" "ca-org3" "admin"
# scripts/register.sh false "org3.example.com" "org3" "ca-org3" "peer0" "peer"
# scripts/register.sh false "org3.example.com" "org3" "ca-org3" "user1" "client"
# scripts/register.sh false "org3.example.com" "org3" "ca-org3" "org3admin" "admin"
# scripts/enroll.sh false false "msp" "host" "org3.example.com" "11054" "org3" "ca-org3" "peer0"
# scripts/enroll.sh false false "tls" "" "org3.example.com" "11054" "org3" "ca-org3" "peer0"
# scripts/enroll.sh false false "msp" "user" "org3.example.com" "11054" "org3" "ca-org3" "user1"
# scripts/enroll.sh false false "msp" "user" "org3.example.com" "11054" "org3" "ca-org3" "org3admin"
# ./organizations/ccp-generate.sh "3" "11051" "11054" "org3.example.com"

# scripts/generateOrgDefinition.sh "Org3" "org3.example.com" false
# scripts/startNodes.sh true
# sleep 5

# docker exec cli ./scripts/setAddedOrg.sh 3 "mychannel" "org3.example.com" "3" "10" false
# docker exec cli ./scripts/fetchConfigBlock.sh 3 "mychannel" false
# scripts/joinChannel.sh "mychannel" 3 false "1" "5"
# docker exec cli ./scripts/setAnchorPeer.sh 3 "mychannel"

exit 0

