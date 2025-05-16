// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Strings.sol";

contract HaikuNFT {
    uint256 public counter;

    struct Haiku {
        address author;
        string line1;
        string line2;
        string line3;
    }

    Haiku[] haikus;

    mapping(address => uint256) public sharedHaikus;

    string public name;
    string public symbol;

    constructor(string memory _name, string memory _symbol) {
        counter = 1;
        name = _name;
        symbol = _symbol;
        haikus.push();
    }

    error HaikuNotUnique();

    function mintHaiku(string memory _line1, string memory _line2, string memory _line3) external {

        bool doesAlreadyExist = false;
        for (uint i = 0; i < haikus.length; i++) {
            Haiku memory currentHaiku = haikus[i];
            if (Strings.equal(currentHaiku.line1,_line1) || Strings.equal(currentHaiku.line1,_line2) || Strings.equal(currentHaiku.line1,_line3) 
                || Strings.equal(currentHaiku.line2,_line1) || Strings.equal(currentHaiku.line2,_line2) || Strings.equal(currentHaiku.line2,_line3)
                || Strings.equal(currentHaiku.line3,_line1) || Strings.equal(currentHaiku.line3,_line2) || Strings.equal(currentHaiku.line3,_line3)) {
                doesAlreadyExist = true;
            }
        }

        if (doesAlreadyExist) {
            revert HaikuNotUnique();
        }

       Haiku memory newHaiku = Haiku({
        author: msg.sender,
        line1: _line1,
        line2: _line2,
        line3: _line3
       });

        // haikus[counter] = newHaiku;
        haikus.push(newHaiku);
        counter += 1;
    }

    error NotYourHaiku(uint256 _id);
    
    function shareHaiku(uint256 _id,  address _to) public {
        if (_id == 0) {
            revert("Invalid Id");
        }
        if (counter < _id) {
            revert("Invalid Id");
        }   
        Haiku memory currentHaiku = haikus[_id];
        if (currentHaiku.author != msg.sender) {
            revert NotYourHaiku(_id);
        }
        sharedHaikus[_to] = _id;

    }

    error NoHaikusShared();

    function getMySharedHaikus() public view returns (Haiku[] memory) {
        uint256 sharedHaikuId = sharedHaikus[msg.sender];
        if (sharedHaikuId == 0) {
            revert NoHaikusShared();
        }
        Haiku memory haiku = haikus[sharedHaikuId];
        Haiku[] memory returnHaikus = new Haiku[](1);
        returnHaikus[0] = haiku;
        return returnHaikus;
    }
}

