#!/bin/bash

function one_line_pem {
    echo "`awk 'NF {sub(/\\n/, ""); printf "%s\\\\\\\n",$0;}' $1`"
}

function json_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        organizations/ccp-template.json
}

function yaml_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        organizations/ccp-template.yaml | sed -e $'s/\\\\n/\\\n        /g'
}

ORG=${1:-"3"}
P0PORT=${2:-"11051"}
CAPORT=${3:-"11054"}
DOMAIN=${4:-"org3.example.com"}
PEERPEM=${TEST_NETWORK_HOME}/organizations/peerOrganizations/${DOMAIN}/tlsca/tlsca.${DOMAIN}-cert.pem
CAPEM=${TEST_NETWORK_HOME}/organizations/peerOrganizations/${DOMAIN}/ca/ca.${DOMAIN}-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > ${TEST_NETWORK_HOME}/organizations/peerOrganizations/${DOMAIN}/connection-org${ORG}.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > ${TEST_NETWORK_HOME}/organizations/peerOrganizations/${DOMAIN}/connection-org${ORG}.yaml
