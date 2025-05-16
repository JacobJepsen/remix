// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

contract Greeting {
    mapping(address => uint) public favoriteNumbers;
    address[] public favoriteNumberKeys;

    function saveFavoriteNumber(uint _value) public {
        if (favoriteNumbers[msg.sender] == 0) {
            favoriteNumberKeys.push(msg.sender);
        }
        favoriteNumbers[msg.sender] = _value;
    }

    function returnAllFavorites() public view returns (uint[] memory) {
        uint[] memory allFavorites = new uint[](favoriteNumberKeys.length);

        for(uint i = 0; i < allFavorites.length; i++) {
            allFavorites[i] = favoriteNumbers[favoriteNumberKeys[i]];
        }

        return allFavorites;
    }
}