#!/bin/bash

. scripts/utils.sh
. scripts/envVar.sh

isOrderer=${1:-false}
domain=${2:-"org1.example.com"}
org=${3:-"org1"}
caName=${4:-"ca-org1"}
account=${5:-"peer0"}
accountType=${6:-"peer"}

if ${isOrderer}; then
  fabricCAClientHome=organizations/${ORDERER_ORGS}/${domain}
else
  fabricCAClientHome=organizations/${PEER_ORGS}/${domain}
fi

export PATH=${PWD}/../bin:$PATH
export FABRIC_CA_CLIENT_HOME=${PWD}/${fabricCAClientHome}

infoln "Registering ${account}"
set -x
fabric-ca-client register --caname ${caName} --id.name ${account} --id.secret ${account}pw --id.type ${accountType} --tls.certfiles "${PWD}/${FABRIC_CA_SERVER_HOME}/${org}/tls-cert.pem"
{ set +x; } 2>/dev/null

exit 0
