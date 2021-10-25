#!/bin/bash

. scripts/utils.sh

domain=${1:-"org1.example.com"}
org=${2:-"org1"}

export PATH=${PWD}/../bin:$PATH
export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/${domain}

infoln "Registering peer"
set -x
fabric-ca-client register --caname ca-${org} --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles "${PWD}/organizations/fabric-ca/${org}/tls-cert.pem"
{ set +x; } 2>/dev/null

exit 0
