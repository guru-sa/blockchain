. .env

dataDir=${1:-"datadir"}
port=${2:-"30301"}

if [ ! -d ${HistoryDir} ]; then
  mkdir ${HistoryDir}
fi

sudo ufw allow ${port}/tcp

geth --datadir ${dataDir} --networkid ${NetworkId} --port ${port} --ipcdisable console 2>> ${HistoryDir}/network.log
