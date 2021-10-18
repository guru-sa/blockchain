// SPDX-License-Identifier: ys-sa
pragma solidity ^0.8.9;

contract Storage {

  struct Name {
    string fName;
    string lName;
  }
  
  mapping(address => Name) public names;
  
  function setName(string _fName, string _lName) public {
    Name n = names[msg.sender];
    n.fName = _fName;
    n.lName = _lName;
  }
  
}
