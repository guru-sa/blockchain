#!/bin/bash

. scripts/utils.sh
. scripts/envVar.sh

isOrderer=${1:-false}
domain=${2:-"org1.example.com"}
port=${3:-"7054"}
org=${4:-"org1"}
caName=${5:-"ca-org1"}
account=${6:-"peer0"}

if ${isOrderer}; then
  fabricCAClientHome=organizations/${ORDERER_ORGS}/${domain}
else
  fabricCAClientHome=organizations/${PEER_ORGS}/${domain}
fi

export PATH=${PWD}/../bin:$PATH
export FABRIC_CA_CLIENT_HOME=${PWD}/${fabricCAClientHome}

infoln "Generating the ${account}-tls certificates"
set -x

if ${isOrderer}; then
  fabric-ca-client enroll -u https://${account}:${account}pw@localhost:${port} --caname ${caName} -M "${PWD}/${fabricCAClientHome}/orderers/${account}.${domain}/tls" --enrollment.profile tls --csr.hosts ${account}.${domain} --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/${org}/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/${fabricCAClientHome}/orderers/${account}.${domain}/tls/tlscacerts/"* "${PWD}/${fabricCAClientHome}/orderers/${account}.${domain}/tls/ca.crt"
  cp "${PWD}/${fabricCAClientHome}/orderers/${account}.${domain}/tls/signcerts/"* "${PWD}/${fabricCAClientHome}/orderers/${account}.${domain}/tls/server.crt"
  cp "${PWD}/${fabricCAClientHome}/orderers/${account}.${domain}/tls/keystore/"* "${PWD}/${fabricCAClientHome}/orderers/${account}.${domain}/tls/server.key"

  mkdir -p "${PWD}/${fabricCAClientHome}/msp/tlscacerts"
  cp "${PWD}/${fabricCAClientHome}/orderers/${account}.${domain}/tls/tlscacerts/"* "${PWD}/${fabricCAClientHome}/msp/tlscacerts/ca.crt"

  mkdir -p "${PWD}/${fabricCAClientHome}/tlsca"
  cp "${PWD}/${fabricCAClientHome}/orderers/${account}.${domain}/tls/tlscacerts/"* "${PWD}/${fabricCAClientHome}/tlsca/tlsca.${domain}-cert.pem"

  mkdir -p "${PWD}/${fabricCAClientHome}/ca"
  cp "${PWD}/${fabricCAClientHome}/orderers/${account}.${domain}/msp/cacerts/"* "${PWD}/${fabricCAClientHome}/ca/ca.${domain}-cert.pem"
else
  fabric-ca-client enroll -u https://${account}:${account}pw@localhost:${port} --caname ${caName} -M "${PWD}/${fabricCAClientHome}/peers/${account}.${domain}/tls" --enrollment.profile tls --csr.hosts ${account}.${domain} --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/${org}/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/${fabricCAClientHome}/peers/${account}.${domain}/tls/tlscacerts/"* "${PWD}/${fabricCAClientHome}/peers/${account}.${domain}/tls/ca.crt"
  cp "${PWD}/${fabricCAClientHome}/peers/${account}.${domain}/tls/signcerts/"* "${PWD}/${fabricCAClientHome}/peers/${account}.${domain}/tls/server.crt"
  cp "${PWD}/${fabricCAClientHome}/peers/${account}.${domain}/tls/keystore/"* "${PWD}/${fabricCAClientHome}/peers/${account}.${domain}/tls/server.key"

  mkdir -p "${PWD}/${fabricCAClientHome}/msp/tlscacerts"
  cp "${PWD}/${fabricCAClientHome}/peers/${account}.${domain}/tls/tlscacerts/"* "${PWD}/${fabricCAClientHome}/msp/tlscacerts/ca.crt"

  mkdir -p "${PWD}/${fabricCAClientHome}/tlsca"
  cp "${PWD}/${fabricCAClientHome}/peers/${account}.${domain}/tls/tlscacerts/"* "${PWD}/${fabricCAClientHome}/tlsca/tlsca.${domain}-cert.pem"

  mkdir -p "${PWD}/${fabricCAClientHome}/ca"
  cp "${PWD}/${fabricCAClientHome}/peers/${account}.${domain}/msp/cacerts/"* "${PWD}/${fabricCAClientHome}/ca/ca.${domain}-cert.pem"
fi
exit 0
