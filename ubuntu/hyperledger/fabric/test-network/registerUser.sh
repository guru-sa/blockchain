#!/bin/bash

. scripts/utils.sh

domain=${1:-"org1.example.com"}
org=${2:-"org1"}

export PATH=${PWD}/../bin:$PATH
export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/${domain}

infoln "Registering user"
set -x
fabric-ca-client register --caname ca-${org} --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "${PWD}/organizations/fabric-ca/${org}/tls-cert.pem"
{ set +x; } 2>/dev/null

exit 0
