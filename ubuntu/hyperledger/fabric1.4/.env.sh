#!/bin/bash
SCRIPT=`realpath -s $0`
SCRIPTPATH=`dirname ${SCRIPT}`
SCRIPTNAME=`basename ${SCRIPT}`

echo "export PATH=\$PATH:${SCRIPTPATH}/bin" >> ~/.profile
source ~/.profile
