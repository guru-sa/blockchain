// SPDX-License-Identifier: ys-sa
pragma solidity ^0.8.9;

contract CrowdFunding {

  struct Funder {
    address addr;
    uint amount;
    bool isApproved;
  }
  
  Funder[] contributors;
  
  function contribute() public payable {
    Funder memory contributor = Funder( {
      addr: msg.sender,
      amount: msg.value,
      isApproved: false
    });
    contributors.push(contributor);
  }
  
  function approve(uint id) public {
    Funder storage contributor = contributors[id];
    contributor.isApproved = true;
  }
  
  function getContributor(uint id) public view returns (address, uint, bool) {
    Funder memory contributor = contributors[id];
    return (contributor.addr, contributor.amount, contributor.isApproved);
  }
}

