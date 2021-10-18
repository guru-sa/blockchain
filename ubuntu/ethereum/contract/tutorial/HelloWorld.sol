// SPDX-License-Identifier: ys-sa
pragma solidity ^0.8.9;

contract HelloWorld {

  string public greeting = "Hello World";
  
  event greetingChanged(address by, string greeting);
  
  function changeGreeting(string memory _newGreeting) public {
    greeting = _newGreeting;
    emit greetingChanged(msg.sender, _newGreeting);  
  }
   
}

