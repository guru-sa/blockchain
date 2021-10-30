#!/bin/bash
SCRIPT=`realpath -s $0`
SCRIPTPATH=`dirname ${SCRIPT}`
SCRIPTNAME=`basename ${SCRIPT}`
cd ${SCRIPTPATH}
. utils.sh
. envVar.sh

isOrderer=${1:-false}
domain=${2:-"org1.example.com"}
org=${3:-"org1"}
caName=${4:-"ca-org1"}
account=${5:-"peer0"}
accountType=${6:-"peer"}

if ${isOrderer}; then
  fabricCAClientHome=${TEST_NETWORK_HOME}/organizations/${ORDERER_ORGS}/${domain}
else
  fabricCAClientHome=${TEST_NETWORK_HOME}/organizations/${PEER_ORGS}/${domain}
fi

export FABRIC_CA_CLIENT_HOME=${fabricCAClientHome}

infoln "Registering ${account}"
set -x
fabric-ca-client register --caname ${caName} --id.name ${account} --id.secret ${account}pw --id.type ${accountType} --tls.certfiles "${FABRIC_CA_SERVER_HOME}/${org}/tls-cert.pem"
{ set +x; } 2>/dev/null

exit 0
