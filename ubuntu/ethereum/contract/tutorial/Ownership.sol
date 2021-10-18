// SPDX-License-Identifier: ys-sa
pragma solidity ^0.8.9;

contract Ownership {

  address owner;
  function Ownership() public {
    owner = msg.sender;
  }
  
  modifier onlyOwner {
    require(msg.sender == owner);
    _;
  }
}

