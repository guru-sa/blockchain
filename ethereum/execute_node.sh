# ---network id--- 
# 1: Frontier(default)
# 2: Morden(expired)
# 3: Ropsten(PoW)
# 4: Rinkeby(PoA)
networkId=${1:-"3"}
keystoreDir=${2:-"./ropsten-db"}
dataDir=${3:-"./ropsten-keys"}
syncMode=${4:-"fast"}
# The names of the HTTP/RPC-related options were changed
# rpcAddr=${5:-""}
# rpcPort=${6:-"8546"}
# rpcAPI=${7:-"web3,eth,miner,admin"}
# rpcCorsDomain=${8:-"*"}
# rpcGascap={9:-""}
# rpcVHosts={10:-""}
httpAddr=${5:-""}
httpPort=${6:-"8546"}
httpAPI=${7:-"web3,eth,miner,admin"}
httpRpcPrefix=${8:-""}
httpCorsDomain=${9:-"*"}
httpVHosts=${10:-""}
port=${11:-"30301"}

geth --networkid ${networkId} --datadir ${dataDir} --keystore ${keystoreDir} --syncmode ${syncMode} --http --http.port ${httpPort} --http.api ${httpAPI} --http.corsdomain ${httpCorsDomain} --port ${port} console

