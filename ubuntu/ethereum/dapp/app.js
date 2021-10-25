
var Web3 = require("web3");
var Eth = require("web3-eth");
var Bzz = require("web3-bzz");
var Shh = require("web3-shh");
var solc = require("solc");

/* 
var web3 = new Web3("ws://localhost:8546");
var eth = new Eth("ws://localhost:8546");
var bzz = new Bzz("http://localhost:8500");
var shh = new Shh("ws://localhost:8546");

var web3 = new Web3(
  new Web3.providers.HttpProvider("http://localhost:8545")
);
*/
var web3 = new Web3(Web3.givenProvider || "ws://localhost:8546");
//web3.eth.accounts.create("<random entropy>");
//web3.eth.accounts.privateKeyToAccount("<privateKey>");
var account = web3.eth.accounts.create();
console.log(account);
//web.personal.unlockAccount("<address>", "<password>", <duration>);
//web3.eth.personal.unlockAccount("<address>", "<password>", <duration>).then(console.log);

var contract = "";
var output = solc.compile(contract, 1);

for (var contractName in output.contracts) {
  console.log(contractName);
  var bytecode = output.contracts[contractName].bytecode;
  var abi = output.contracts[contractName].interface;
  /*
  web3.eth.sendTransaction({
    from: "",
    data: bytecode,
    gas: "4700000"
  }, function(error, transactionHash) {
    if (!error) console.log(transactionHash);
  })
  web3.eth.sendTransaction({
    from: "",
    data: bytecode,
    gas: "4700000"
  })
  .on('receipt', function(receipt) {
    console.log(receipt);
  }) 
  */
  /*
  var helloworldContract = web3.eth.contract(abi);
  var helloworld = helloworldContract.new({
    from: "",
    data: bytecode,
    gas: "4700000"
  }, function(e, contract) {
    if (typeof contract.address !== "undefined") {
      console.log("address: " + contract.address);
    }
  });
  
  var helloWorld = new web3.eth.Contract(abi);
  var gas = web3.eth.estimateGas({
    data: bytecode
  });
  console.log(gas);
  helloWorld.deploy({
    data: bytecode,
    arguments: []
  })
  .send({
    from: "",
    gas: "4700000"
  })
  .on("error", function(error) {
    console.error(error);
  })
  .on("receipt", function(receipt) {
    console.log(receipt.contractAddress);
  });
  */
}
/* Transaction
web3.eth.sendTransaction({
  from: "",
  to: "",
  gas: 21000,
  gasPrice: 20000000000,
  value: 200000
  //data:
  //nonce:
}, function(error, transactionHash) {
  if (!error) console.log(transactionHash);
})

web3.eth.sendTransaction({
  from: "",
  to: "",
  value:
})
.on('transactionHash', function(hash) {
  console.log(hash);
})
.on('receipt', function(receipt) {
  console.log(receipt);
})
.on('confirmation', function(confirmationNumber, receipt) {
  console.log(confirmationNumber);
})
.on('error', console.error);
*/

//console.log(web3.eth.coinbase);
//console.log(web3.eth.getBalance("0x32625e5740DEfC41917480C14B6eC710344a066A"));
//web3.eth.getCoinbase().then(console.log);
//web3.eth.getBalance("32625e5740DEfC41917480C14B6eC710344a066A").then(console.log);
//web3.eth.getAccounts().then(console.log);







