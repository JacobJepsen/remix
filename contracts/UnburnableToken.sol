// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.23;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract UnburnableToken {
    mapping(address => uint) public balances;
    uint public totalSupply;
    uint public totalClaimed;

    address[] public claimers;

    constructor() {
        totalSupply = 100000000;

    }

    error AllTokensClaimed();

    function claim() public {
        if (totalClaimed == 100000000) {
            revert AllTokensClaimed();
        }
        bool hasAlreadyClaimed = false;
        for (uint i = 0; i < claimers.length; i++) {
            if (msg.sender == claimers[i]) {
                hasAlreadyClaimed = true;
            }
        }

        if (!hasAlreadyClaimed) {
            totalClaimed += 1000;
            balances[msg.sender] += 1000;
            claimers.push(msg.sender);
        }

    }

    error UnsafeTransfer(address _to);

    function safeTransfer(address _to, uint _amount) public {
        if (_to == address(0) || address(msg.sender).balance == 0) {
            revert UnsafeTransfer(_to);
        }
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
        
    }

}