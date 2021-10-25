#!/bin/bash

. scripts/utils.sh
. scripts/envVar.sh

isOrderer=${1:-false}
domain=${2:-"org1.example.com"}
port=${3:-"7054"}
org=${4:-"org1"}
caName=${5:-"ca-org1"}

infoln "Enrolling the CA admin"

if ${isOrderer}; then
  fabricCAClientHome=organizations/${ORDERER_ORGS}/${domain}
else
  fabricCAClientHome=organizations/${PEER_ORGS}/${domain}
fi

mkdir -p ${fabricCAClientHome}

export PATH=${PWD}/../bin:$PATH
export FABRIC_CA_CLIENT_HOME=${PWD}/${fabricCAClientHome}

set -x
fabric-ca-client enroll -u https://admin:adminpw@localhost:${port} --caname ${caName} --tls.certfiles "${PWD}/organizations/fabric-ca/${org}/tls-cert.pem"
{ set +x; } 2>/dev/null

echo 'NodeOUs:
Enable: true
ClientOUIdentifier:
  Certificate: cacerts/localhost-${port}-${caName}.pem
  OrganizationalUnitIdentifier: client
PeerOUIdentifier:
  Certificate: cacerts/localhost-${port}-${caName}.pem
  OrganizationalUnitIdentifier: peer
AdminOUIdentifier:
  Certificate: cacerts/localhost-${port}-${caName}.pem
  OrganizationalUnitIdentifier: admin
OrdererOUIdentifier:
  Certificate: cacerts/localhost-${port}-${caName}.pem
  OrganizationalUnitIdentifier: orderer' > "${PWD}/${fabricCAClientHome}/msp/config.yaml"

exit 0
