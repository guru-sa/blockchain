#!/bin/bash

. scripts/utils.sh

export PATH=${PWD}/../bin:$PATH

CA_IMAGETAG="1.5.2"
COMPOSE_FILE_CA=docker/docker-compose-ca.yaml

fabric-ca-client version > /dev/null 2>&1
if [[ $? -ne 0 ]]; then
  errorln "fabric-ca-client binary not found.."
  errorln
  errorln "Follow the instructions in the Fabric docs to install the Fabric Binaries:"
  errorln "https://hyperledger-fabric.readthedocs.io/en/latest/install.html"
  exit 1
fi
CA_LOCAL_VERSION=$(fabric-ca-client version | sed -ne 's/ Version: //p')
CA_DOCKER_IMAGE_VERSION=$(docker run --rm hyperledger/fabric-ca:$CA_IMAGETAG fabric-ca-client version | sed -ne 's/ Version: //p' | head -1)
infoln "CA_LOCAL_VERSION=$CA_LOCAL_VERSION"
infoln "CA_DOCKER_IMAGE_VERSION=$CA_DOCKER_IMAGE_VERSION"

if [ "$CA_LOCAL_VERSION" != "$CA_DOCKER_IMAGE_VERSION" ]; then
  warnln "Local fabric-ca binaries and docker images are out of sync. This may cause problems."
fi
    
infoln "Generating certificates using Fabric CA"

IMAGE_TAG=${CA_IMAGETAG} docker-compose -f $COMPOSE_FILE_CA up -d 2>&1

exit 0
