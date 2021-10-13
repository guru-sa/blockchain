# ethereum

# Can see list of peers executed 
admin.peers

# Check the state of sync 
eth.syncing

# Other node can connect the node executed
geth attch http://localhost:8546
geth --verbosity 5 console 2 >> /tmp/eth-node.log
geth exec "eth.accounts" attach http://localhost:8546
geth --jspath "/home" --exec 'loadScript("sendTransaction.js")' attach http://localhost:8546

# Web3 deals with node 
web3

# Admin API manages node
admin
admin.nodeInfo
admin.peers

# Using eth object, you can process something associated with ethereum blockchain
eth
eth.blockNumber
eth.getBlock(301) 

# Ethereum account is managed personal method
personal

# mining 
miner

# txpool
txpool



