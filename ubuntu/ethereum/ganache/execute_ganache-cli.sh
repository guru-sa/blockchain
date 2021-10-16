#!/bin/bash
accountNumber=${1:-"5"}
amountOfEth=${2:-"2000"}
port=${3:-"8545"}
maximumAmountOfGasPerBlock=${4:-"999999"}

ganache-cli -a ${accountNumber} -e ${amountOfEth} -p ${port} -l ${maximumAmountOfGasPerBlock}
