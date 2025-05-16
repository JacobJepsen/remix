// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.23;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MinimalToken {
    mapping(address => uint) public balances;
    uint public totalSupply;

    constructor() {
        totalSupply = 3000;
        balances[msg.sender] = totalSupply / 3;
        balances[0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2] = totalSupply / 3;
        balances[0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db] = totalSupply / 3;
    }

    function transfer(address _to, uint _amount) public {
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
        

    }

}