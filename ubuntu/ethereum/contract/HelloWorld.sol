pragma solidity ^0.8.9;

contract HelloWorld {
  string textToPrint = "hello world";
  
  /* keyword view means read only */
  function printSomething() view returns (string) {
    return textToPrint;
  }
  
  function changeText(string _text) {
    textToPrint = _text;
  }
 
}

