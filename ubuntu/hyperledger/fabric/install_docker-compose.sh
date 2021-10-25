#!/bin/bash
SCRIPT=`realpath -s $0`
SCRIPTPATH=`dirname ${SCRIPT}`
SCRIPTNAME=`basename ${SCRIPT}`
cd ${SCRIPTPATH}

checkResult() {
  if [ "${1}" -ne "0" ]; then
    exit 1
  fi
}

sudo curl -L https://github.com/docker/compose/releases/download/1.29.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
checkResult $?

chmod +x /usr/local/bin/docker-compose
checkResult $?

exit 0
