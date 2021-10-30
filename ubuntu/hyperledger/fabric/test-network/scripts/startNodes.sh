#!/bin/bash
SCRIPT=`realpath -s $0`
SCRIPTPATH=`dirname ${SCRIPT}`
SCRIPTNAME=`basename ${SCRIPT}`
cd ${SCRIPTPATH}

. utils.sh

isAdd=${1:-false}

IMAGETAG="2.3.3"
DATABASE="leveldb"

if ${isAdd}; then
  COMPOSE_FILE_BASE=docker/docker-compose-org3.yaml
  COMPOSE_FILE_COUCH=docker/docker-compose-couch-org3.yaml
else
  COMPOSE_FILE_BASE=docker/docker-compose-test-net.yaml
  COMPOSE_FILE_COUCH=docker/docker-compose-couch.yaml
fi

peer version > /dev/null 2>&1

if [[ $? -ne 0 || ! -d "config" ]]; then
  errorln "Peer binary and configuration files not found.."
  errorln
  errorln "Follow the instructions in the Fabric docs to install the Fabric Binaries:"
  errorln "https://hyperledger-fabric.readthedocs.io/en/latest/install.html"
  exit 1
fi
# use the fabric tools container to see if the samples and binaries match your
# docker images
LOCAL_VERSION=$(peer version | sed -ne 's/ Version: //p')
DOCKER_IMAGE_VERSION=$(docker run --rm hyperledger/fabric-tools:$IMAGETAG peer version | sed -ne 's/ Version: //p' | head -1)

infoln "LOCAL_VERSION=$LOCAL_VERSION"
infoln "DOCKER_IMAGE_VERSION=$DOCKER_IMAGE_VERSION"

if [ "$LOCAL_VERSION" != "$DOCKER_IMAGE_VERSION" ]; then
  warnln "Local fabric binaries and docker images are out of  sync. This may cause problems."
fi

COMPOSE_FILES="-f ${COMPOSE_FILE_BASE}"

if [ "${DATABASE}" == "couchdb" ]; then
  COMPOSE_FILES="${COMPOSE_FILES} -f ${COMPOSE_FILE_COUCH}"
fi
IMAGE_TAG=$IMAGETAG docker-compose ${COMPOSE_FILES} up -d 2>&1
if [ $? -ne 0 ]; then
  fatalln "ERROR !!!! Unable to start node"
fi
exit 0
