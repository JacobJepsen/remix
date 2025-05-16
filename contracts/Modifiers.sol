// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;


contract Modifiers {
    address owner;

    constructor () {
        owner = msg.sender;
    }

    error NotOwner(address _msgSender);

    modifier onlyOwner {
    if (msg.sender != owner) {
        revert NotOwner(msg.sender);
    }
    _;
    }

    function iOwnThis() public view onlyOwner returns (string memory) {
        return "You own this!";
    }

}