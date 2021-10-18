// SPDX-License-Identifier: ys-sa
pragma solidity ^0.8.9;

contract Token {

  address owner;
  
  constructor() {
    owner = msg.sender;
  }
  
  event Transfer(address indexed _from, address indexed _to, uint _value);
  
  modifier onlyOwner {
    require(msg.sender == owner);
    _;
  }
  
  mapping(address => uint) public balances;
  
  function mint(address _to, uint _value) public onlyOwner {
    balances[_to] += _value;
    emit Transfer(address(0), _to, _value);
  }
  
  function transfer(address _to, uint _value) public {
    require(balances[msg.sender] >= _value);
    balances[msg.sender] -= _value;
    balances[_to] += _value;
    emit Transfer(msg.sender, _to, _value);
  }
  
}

