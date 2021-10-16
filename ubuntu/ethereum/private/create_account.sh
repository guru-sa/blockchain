. .env
dataDir=${1:-"datadir"}

if [ -d ${dataDir} ]; then
  rm -rf ${dataDir}
fi

if [ ! -d ${HistoryDir} ]; then
  mkdir ${HistoryDir}
fi

geth account new --datadir ${dataDir} --password <(echo $PASSWORD) 1>${HistoryDir}/account.log

accountFile=`cut -f 2 -d ':' ${HistoryDir}/account.log | grep data`
accountAddress=`jq .address ${accountFile}`

if [ -f ${Genesis} ]; then
  rm ${Genesis}
fi

cp ../template/template_genesis.json ./${Genesis}

sed -i 's/__NETWORKID__/'${NetworkId}'/g' ./${Genesis}
sed -i 's/__ACCOUNT_ADDRESS__/'${accountAddress}'/g' ./${Genesis}

exit 0
