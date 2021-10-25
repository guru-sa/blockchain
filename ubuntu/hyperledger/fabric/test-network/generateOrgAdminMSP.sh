#!/bin/bash

. scripts/utils.sh

domain=${1:-"org1.example.com"}
port=${2:-"7054"}
org=${3:-"org1"}

export PATH=${PWD}/../bin:$PATH
export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/${domain}

infoln "Generating the org admin msp"
set -x
fabric-ca-client enroll -u https://org1admin:org1adminpw@localhost:${port} --caname ca-${org} -M "${PWD}/organizations/peerOrganizations/${domain}/users/Admin@${domain}/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/${org}/tls-cert.pem"
{ set +x; } 2>/dev/null

cp "${PWD}/organizations/peerOrganizations/${domain}/msp/config.yaml" "${PWD}/organizations/peerOrganizations/${domain}/users/Admin@${domain}/msp/config.yaml"

exit 0
