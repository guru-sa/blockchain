// SPDX-License-Identifier: ys-sa
pragma solidity ^0.8.9;

contract Donate is Ownership {

  bool locked;
  modifier noReentrancy() {
    require(!locked);
    locked = true;
    _;
    locked = false;
  }
  
  function claim() onlyOwner public {
    require(msg.sender.call());
  }
  
  function donate(address _user) noReentrancy public {
    require(_user.call());
  }
  
}

