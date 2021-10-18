#!/bin/bash

fileName=${1:-""}
isAst=${2:-false}
isAsm=${3:-false}
isAbi=${4:-false}
isOpcodes=${5:-false}

params=""
if ${isAst}; then
  params=${params} --ast
fi
if ${isAsm}; then
  params=${params} --asm
fi
if ${isAbi}; then
  params=${params} --abi
fi
if ${isOpcodes}; then
  params=${params} --opcodes
fi

solc -o bin --optimize --bin ${params} ${fileName} 

