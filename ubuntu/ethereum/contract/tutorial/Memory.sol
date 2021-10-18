// SPDX-License-Identifier: ys-sa
pragma solidity ^0.8.9;

contract memory {

  struct Name {
    string fName;
    string lName;
  }
  
  mapping(address => Name) public names;
  
  function setName(string _fName, string _lName) public {
    Name memory n = Name({
      fName: _fName,
      lName: _lName
    });
    names[msg.sender] = n;
  }
  
}
