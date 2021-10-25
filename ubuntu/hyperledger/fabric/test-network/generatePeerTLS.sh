#!/bin/bash

. scripts/utils.sh

domain=${1:-"org1.example.com"}
port=${2:-"7054"}
org=${3:-"org1"}

export PATH=${PWD}/../bin:$PATH
export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/${domain}

infoln "Generating the peer-tls certificates"
set -x
fabric-ca-client enroll -u https://peer0:peer0pw@localhost:${port} --caname ca-${org} -M "${PWD}/organizations/peerOrganizations/${domain}/peers/peer0.${domain}/tls" --enrollment.profile tls --csr.hosts peer0.${domain} --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/${org}/tls-cert.pem"
{ set +x; } 2>/dev/null

cp "${PWD}/organizations/peerOrganizations/${domain}/peers/peer0.${domain}/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/${domain}/peers/peer0.${domain}/tls/ca.crt"
cp "${PWD}/organizations/peerOrganizations/${domain}/peers/peer0.${domain}/tls/signcerts/"* "${PWD}/organizations/peerOrganizations/${domain}/peers/peer0.${domain}/tls/server.crt"
cp "${PWD}/organizations/peerOrganizations/${domain}/peers/peer0.${domain}/tls/keystore/"* "${PWD}/organizations/peerOrganizations/${domain}/peers/peer0.${domain}/tls/server.key"

mkdir -p "${PWD}/organizations/peerOrganizations/${domain}/msp/tlscacerts"
cp "${PWD}/organizations/peerOrganizations/${domain}/peers/peer0.${domain}/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/${domain}/msp/tlscacerts/ca.crt"

mkdir -p "${PWD}/organizations/peerOrganizations/${domain}/tlsca"
cp "${PWD}/organizations/peerOrganizations/${domain}/peers/peer0.${domain}/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/${domain}/tlsca/tlsca.${domain}-cert.pem"

mkdir -p "${PWD}/organizations/peerOrganizations/${domain}/ca"
cp "${PWD}/organizations/peerOrganizations/${domain}/peers/peer0.${domain}/msp/cacerts/"* "${PWD}/organizations/peerOrganizations/${domain}/ca/ca.${domain}-cert.pem"

exit 0
