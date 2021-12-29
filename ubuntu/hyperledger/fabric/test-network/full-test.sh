#!/bin/bash
SCRIPT=`realpath -s $0`
SCRIPTPATH=`dirname ${SCRIPT}`
SCRIPTNAME=`basename ${SCRIPT}`
cd ${SCRIPTPATH}

# scripts/startCA.sh false
# sleep 5
# scripts/enroll.sh false true "" "" "org1.seogang.com" "7054" "org1" "ca-org1" "admin"
# sleep 1
# scripts/register.sh false "org1.seogang.com" "org1" "ca-org1" "peer0" "peer"
# sleep 1
# scripts/register.sh false "org1.seogang.com" "org1" "ca-org1" "user1" "client"
# sleep 1
# scripts/register.sh false "org1.seogang.com" "org1" "ca-org1" "org1admin" "admin"
# sleep 1
# scripts/enroll.sh false false "msp" "host" "org1.seogang.com" "7054" "org1" "ca-org1" "peer0"
# sleep 1
# scripts/enroll.sh false false "tls" "" "org1.seogang.com" "7054" "org1" "ca-org1" "peer0"
# sleep 1
# scripts/enroll.sh false false "msp" "user" "org1.seogang.com" "7054" "org1" "ca-org1" "user1"
# sleep 1
# scripts/enroll.sh false false "msp" "user" "org1.seogang.com" "7054" "org1" "ca-org1" "org1admin"
# sleep 1
# ./organizations/ccp-generate.sh "1" "7051" "7054" "org1.seogang.com"
# sleep 1

# scripts/enroll.sh false true "" "" "org2.seogang.com" "8054" "org2" "ca-org2" "admin"
# sleep 1
# scripts/register.sh false "org2.seogang.com" "org2" "ca-org2" "peer0" "peer"
# sleep 1
# scripts/register.sh false "org2.seogang.com" "org2" "ca-org2" "user1" "client"
# sleep 1
# scripts/register.sh false "org2.seogang.com" "org2" "ca-org2" "org2admin" "admin"
# sleep 1
# scripts/enroll.sh false false "msp" "host" "org2.seogang.com" "8054" "org2" "ca-org2" "peer0"
# sleep 1
# scripts/enroll.sh false false "tls" "" "org2.seogang.com" "8054" "org2" "ca-org2" "peer0"
# sleep 1
# scripts/enroll.sh false false "msp" "user" "org2.seogang.com" "8054" "org2" "ca-org2" "user1"
# sleep 1
# scripts/enroll.sh false false "msp" "user" "org2.seogang.com" "8054" "org2" "ca-org2" "org2admin"
# sleep 1
# ./organizations/ccp-generate.sh "2" "9051" "8054" "org2.seogang.com"
# sleep 1

# scripts/enroll.sh false true "" "" "org3.seogang.com" "9054" "org3" "ca-org3" "admin"
# sleep 1
# scripts/register.sh false "org3.seogang.com" "org3" "ca-org3" "peer0" "peer"
# sleep 1
# scripts/register.sh false "org3.seogang.com" "org3" "ca-org3" "user1" "client"
# sleep 1
# scripts/register.sh false "org3.seogang.com" "org3" "ca-org3" "org3admin" "admin"
# sleep 1
# scripts/enroll.sh false false "msp" "host" "org3.seogang.com" "9054" "org3" "ca-org3" "peer0"
# sleep 1
# scripts/enroll.sh false false "tls" "" "org3.seogang.com" "9054" "org3" "ca-org3" "peer0"
# sleep 1
# scripts/enroll.sh false false "msp" "user" "org3.seogang.com" "9054" "org3" "ca-org3" "user1"
# sleep 1
# scripts/enroll.sh false false "msp" "user" "org3.seogang.com" "9054" "org3" "ca-org3" "org3admin"
# sleep 1
# ./organizations/ccp-generate.sh "3" "11051" "9054" "org3.seogang.com"
# sleep 1
# scripts/enroll.sh true true "" "" "seogang.com" "10054" "ordererOrg" "ca-orderer" "admin"
# sleep 1
# scripts/register.sh true "seogang.com" "ordererOrg" "ca-orderer" "orderer" "orderer"
# sleep 1
# scripts/register.sh true "seogang.com" "ordererOrg" "ca-orderer" "ordererAdmin" "admin"
# sleep 1
# scripts/enroll.sh true false "msp" "host" "seogang.com" "10054" "ordererOrg" "ca-orderer" "orderer"
# sleep 1
# scripts/enroll.sh true false "tls" "" "seogang.com" "10054" "ordererOrg" "ca-orderer" "orderer"
# sleep 1
# scripts/enroll.sh true false "msp" "user" "seogang.com" "10054" "ordererOrg" "ca-orderer" "ordererAdmin"
# sleep 1
# scripts/startNodes.sh false
# sleep 5
# scripts/createChannelGenesisBlock.sh "mychannel"
# sleep 1
# scripts/createChannel.sh "mychannel" false "1" "5"
# sleep 1
# scripts/joinChannel.sh "mychannel" 1 false "1" "5"
# sleep 1
# scripts/joinChannel.sh "mychannel" 2 false "1" "5"
# sleep 1
# scripts/joinChannel.sh "mychannel" 3 false "1" "5"
# sleep 1
# docker exec cli ./scripts/setAnchorPeer.sh 1 "mychannel"
# sleep 1
# docker exec cli ./scripts/setAnchorPeer.sh 2 "mychannel"
# sleep 1
# docker exec cli ./scripts/setAnchorPeer.sh 3 "mychannel"
# sleep 1
scripts/deployCC.sh "mychannel" "mole" "go" "1.0" "1" "" "" "" "" "3" "5" "false"
# scripts/deployCC.sh "mychannel" "assetTransfer" "go" "1.0" "1" "" "" "" "" "3" "5" "false"

# scripts/invoke.sh "mychannel" "abstore" "invoke" "\"a\",\"b\",\"1\"" "3" "5" "false"
# scripts/query.sh "mychannel" "abstore" "query" "\"a\"" "3" "5" "false"

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

