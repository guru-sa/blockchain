. .env
dataDir=${1:-"datadir"}
geth --datadir ${dataDir} init ${Genesis}
