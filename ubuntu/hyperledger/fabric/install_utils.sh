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

. ~/.bashrc
set -x

sudo apt-get update
checkResult $?

sudo apt-get install -y --no-install-recommends apt-utils
checkResult $?

sudo apt-get upgrade -y
checkResult $?

sudo apt-get install -y git
checkResult $?

sudo apt-get install -y curl
checkResult $?

sudo apt-get install -y gcc
checkResult $?

sudo apt-get install -y make
checkResult $?

sudo apt-get install -y openssh-server
checkResult $?

sudo apt-get install -y tree
checkResult $?

sudo apt-get install -y vim
checkResult $?

sudo apt-get install -y net-tools
checkResult $?

sudo apt-get install -y iputils-ping
checkResult $?

sudo apt-get install -y jq
checkResult $?

sudo apt-get install -y dnsutils
checkResult $?

sudo apt-get install -y netcat
checkResult $?

sudo apt-get install -y ntp
checkResult $?

sudo apt-get install -y telnet
checkResult $?

exit 0
