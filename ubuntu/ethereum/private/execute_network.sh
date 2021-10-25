#!/bin/bash

. .env

dataDir=${1:-"datadir"}
port=${2:-"30301"}
syncMode=${3:-"fast"}
# The names of the HTTP/RPC-related options were changed
# rpcAddr=${4:-""}
# rpcPort=${5:-"8546"}
# rpcAPI=${6:-"web3,eth,miner,admin"}
# rpcCorsDomain=${7:-"*"}
# rpcGascap={8:-""}
# rpcVHosts={9:-""}
httpAddr=${4:-""}
httpPort=${5:-"8545"}
httpAPI=${6:-"web3,eth,miner,net,db,admin,personal"}
httpRpcPrefix=${7:-""}
httpCorsDomain=${8:-"*"}
httpVHosts=${9:-""}
if [ ! -d ${HistoryDir} ]; then
  mkdir ${HistoryDir}
fi

sudo ufw allow ${port}/tcp

geth --datadir ${dataDir} --networkid ${NetworkId} --syncmode "${syncMode}" --http --http.port "${httpPort}" --http.api "${httpAPI}" --http.corsdomain "${httpCorsDomain}" --port ${port} --ipcdisable console 2>> ${HistoryDir}/network.log
