// SPDX-License-Identifier: ys-sa
pragma solidity ^0.8.9;

contract Navigation {

  enum Direction {
    North,
    East,
    South,
    West
  }
  
  Direction path = Direction.North;
  
  function changeDirection(Direction dir) public {
    path = dir;
  }
  
  function getCurrentDirection() view public returns (Direction) {
    return path;
  }
}

