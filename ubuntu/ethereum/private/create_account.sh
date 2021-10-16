. .env
dataDir=${1:-"datadir"}

if [ -d ${dataDir} ]; then
  rm -rf ${dataDir}
fi

res=`geth account new --datadir ${dataDir} --password <(echo $PASSWORD)`

accountAddress=`jq .address ${res}`

if [ -f ${Genesis} ]; then
  rm ${Genesis}
fi

cp ../template/template_genesis.json ./${Genesis}

sed -i 's/__NETWORKID__/'${NetworkId}'/g' ./${Genesis}
sed -i 's/__ACCOUNT_ADDRESS__/'${accountAddress}'/g' ./${Genesis}

exit 0
