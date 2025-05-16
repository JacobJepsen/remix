// SPDX-License-Identifier: MIT

pragma solidity ^0.8.23;

contract Complimenter {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }

    function compliment() public view returns(string memory) {
        return string.concat("You look great today, ", name);
    }
}

contract ComplimenterFactory {
    function CreateComplimenter (string memory _name) public returns (address) {
        Complimenter newComplimenter = new Complimenter(_name);
        return address(newComplimenter);
    }
}