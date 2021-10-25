#!/bin/bash

. scripts/utils.sh

domain=${1:-"org1.example.com"}
org=${2:-"org1"}

export PATH=${PWD}/../bin:$PATH
export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/${domain}

infoln "Registering the org admin"
set -x
fabric-ca-client register --caname ca-${org} --id.name org1admin --id.secret org1adminpw --id.type admin --tls.certfiles "${PWD}/organizations/fabric-ca/${org}/tls-cert.pem"
{ set +x; } 2>/dev/null

exit 0
