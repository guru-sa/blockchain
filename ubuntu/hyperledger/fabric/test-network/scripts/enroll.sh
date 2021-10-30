#!/bin/bash
SCRIPT=`realpath -s $0`
SCRIPTPATH=`dirname ${SCRIPT}`
SCRIPTNAME=`basename ${SCRIPT}`
cd ${SCRIPTPATH}

. utils.sh
. envVar.sh

isOrderer=${1:-false}
isCA=${2:-true}
mode=${3:-""}
type=${4:-""}
domain=${5:-"org1.example.com"}
port=${6:-"7054"}
org=${7:-"org1"}
caName=${8:-"ca-org1"}
account=${9:-"admin"}

infoln "Enrolling ${type} ${account} ${mode}"

if ${isOrderer}; then
  fabricCAClientHome=${TEST_NETWORK_HOME}/organizations/${ORDERER_ORGS}/${domain}
else
  fabricCAClientHome=${TEST_NETWORK_HOME}/organizations/${PEER_ORGS}/${domain}
fi

mkdir -p ${fabricCAClientHome}

export FABRIC_CA_CLIENT_HOME=${fabricCAClientHome}

if ${isCA}; then
  set -x
  fabric-ca-client enroll -u https://${account}:${account}pw@localhost:${port} --caname ${caName} --tls.certfiles "${FABRIC_CA_SERVER_HOME}/${org}/tls-cert.pem"
  { set +x; } 2>/dev/null

  echo "NodeOUs:
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
    OrganizationalUnitIdentifier: orderer" > ${fabricCAClientHome}/msp/config.yaml
else
  if ${isOrderer}; then
    if [ "${mode}" == "msp" ]; then
      if [ "${type}" == "host" ]; then
        set -x
        fabric-ca-client enroll -u https://${account}:${account}pw@localhost:${port} --caname ${caName} -M "${fabricCAClientHome}/orderers/${account}.${domain}/msp" --csr.hosts ${account}.${domain} --tls.certfiles "${FABRIC_CA_SERVER_HOME}/${org}/tls-cert.pem"
        { set +x; } 2>/dev/null
        cp "${fabricCAClientHome}/msp/config.yaml" "${fabricCAClientHome}/orderers/${account}.${domain}/msp/config.yaml"
      elif [ "${type}" == "user" ]; then
        set -x
        fabric-ca-client enroll -u https://${account}:${account}pw@localhost:${port} --caname ${caName} -M "${fabricCAClientHome}/users/${account}@${domain}/msp" --tls.certfiles "${FABRIC_CA_SERVER_HOME}/${org}/tls-cert.pem"
        { set +x; } 2>/dev/null
        cp "${fabricCAClientHome}/msp/config.yaml" "${fabricCAClientHome}/users/${account}@${domain}/msp/config.yaml"
      else
        printHelp
        exit 1  
      fi
    elif [ "${mode}" == "tls" ]; then
      set -x
      fabric-ca-client enroll -u https://${account}:${account}pw@localhost:${port} --caname ${caName} -M "${fabricCAClientHome}/orderers/${account}.${domain}/tls" --enrollment.profile tls --csr.hosts ${account}.${domain} --csr.hosts localhost --tls.certfiles "${FABRIC_CA_SERVER_HOME}/${org}/tls-cert.pem"
      { set +x; } 2>/dev/null
      cp "${fabricCAClientHome}/orderers/${account}.${domain}/tls/tlscacerts/"* "${fabricCAClientHome}/orderers/${account}.${domain}/tls/ca.crt"
      cp "${fabricCAClientHome}/orderers/${account}.${domain}/tls/signcerts/"* "${fabricCAClientHome}/orderers/${account}.${domain}/tls/server.crt"
      cp "${fabricCAClientHome}/orderers/${account}.${domain}/tls/keystore/"* "${fabricCAClientHome}/orderers/${account}.${domain}/tls/server.key"

      mkdir -p "${fabricCAClientHome}/msp/tlscacerts"
      cp "${fabricCAClientHome}/orderers/${account}.${domain}/tls/tlscacerts/"* "${fabricCAClientHome}/msp/tlscacerts/ca.crt"

      mkdir -p "${fabricCAClientHome}/tlsca"
      cp "${fabricCAClientHome}/orderers/${account}.${domain}/tls/tlscacerts/"* "${fabricCAClientHome}/tlsca/tlsca.${domain}-cert.pem"

      mkdir -p "${fabricCAClientHome}/ca"
      cp "${fabricCAClientHome}/orderers/${account}.${domain}/msp/cacerts/"* "${fabricCAClientHome}/ca/ca.${domain}-cert.pem"
    else
      printHelp
      exit 1
    fi
  else
    if [ "${mode}" == "msp" ]; then
      if [ "${type}" == "host" ]; then
        set -x
        fabric-ca-client enroll -u https://${account}:${account}pw@localhost:${port} --caname ${caName} -M "${fabricCAClientHome}/peers/${account}.${domain}/msp" --csr.hosts ${account}.${domain} --tls.certfiles "${FABRIC_CA_SERVER_HOME}/${org}/tls-cert.pem"
        { set +x; } 2>/dev/null
        cp "${fabricCAClientHome}/msp/config.yaml" "${fabricCAClientHome}/peers/${account}.${domain}/msp/config.yaml"
      elif [ "${type}" == "user" ]; then
        set -x
        fabric-ca-client enroll -u https://${account}:${account}pw@localhost:${port} --caname ${caName} -M "${fabricCAClientHome}/users/${account}@${domain}/msp" --tls.certfiles "${FABRIC_CA_SERVER_HOME}/${org}/tls-cert.pem"
        { set +x; } 2>/dev/null
        cp "${fabricCAClientHome}/msp/config.yaml" "${fabricCAClientHome}/users/${account}@${domain}/msp/config.yaml"
      else
        printHelp
        exit 1
      fi
    elif [ "${mode}" == "tls" ]; then
      fabric-ca-client enroll -u https://${account}:${account}pw@localhost:${port} --caname ${caName} -M "${fabricCAClientHome}/peers/${account}.${domain}/tls" --enrollment.profile tls --csr.hosts ${account}.${domain} --csr.hosts localhost --tls.certfiles "${FABRIC_CA_SERVER_HOME}/${org}/tls-cert.pem"
      { set +x; } 2>/dev/null

      cp "${fabricCAClientHome}/peers/${account}.${domain}/tls/tlscacerts/"* "${fabricCAClientHome}/peers/${account}.${domain}/tls/ca.crt"
      cp "${fabricCAClientHome}/peers/${account}.${domain}/tls/signcerts/"* "${fabricCAClientHome}/peers/${account}.${domain}/tls/server.crt"
      cp "${fabricCAClientHome}/peers/${account}.${domain}/tls/keystore/"* "${fabricCAClientHome}/peers/${account}.${domain}/tls/server.key"

      mkdir -p "${fabricCAClientHome}/msp/tlscacerts"
      cp "${fabricCAClientHome}/peers/${account}.${domain}/tls/tlscacerts/"* "${fabricCAClientHome}/msp/tlscacerts/ca.crt"

      mkdir -p "${fabricCAClientHome}/tlsca"
      cp "${fabricCAClientHome}/peers/${account}.${domain}/tls/tlscacerts/"* "${fabricCAClientHome}/tlsca/tlsca.${domain}-cert.pem"

      mkdir -p "${fabricCAClientHome}/ca"
      cp "${fabricCAClientHome}/peers/${account}.${domain}/msp/cacerts/"* "${fabricCAClientHome}/ca/ca.${domain}-cert.pem"
    else
      printHelp
      exit 1
    fi
  fi
fi
exit 0
