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

infoln "Generating the peer msp"
set -x

if ${isOrderer}; then
  fabric-ca-client enroll -u https://${account}:${account}pw@localhost:${port} --caname ${caName} -M "${PWD}/${fabricCAClientHome}/orderers/${account}.${domain}/msp" --csr.hosts ${account}.${domain} --tls.certfiles "${PWD}/organizations/fabric-ca/${org}/tls-cert.pem"
  { set +x; } 2>/dev/null
  cp "${PWD}/${fabricCAClientHome}/msp/config.yaml" "${PWD}/${fabricCAClientHome}/orderers/${account}.${domain}/msp/config.yaml"
else
  fabric-ca-client enroll -u https://${account}:${account}pw@localhost:${port} --caname ${caName} -M "${PWD}/${fabricCAClientHome}/peers/${account}.${domain}/msp" --csr.hosts ${account}.${domain} --tls.certfiles "${PWD}/organizations/fabric-ca/${org}/tls-cert.pem"
  { set +x; } 2>/dev/null
  cp "${PWD}/${fabricCAClientHome}/msp/config.yaml" "${PWD}/${fabricCAClientHome}/peers/${account}.${domain}/msp/config.yaml"
fi

exit 0
