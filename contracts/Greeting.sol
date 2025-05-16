// SPDX-License-Identifier: MIT

pragma solidity ^0.8.23;

contract Greeting {
    function sayHello() external pure returns (string memory) {
        return "Hello world";
    }
}