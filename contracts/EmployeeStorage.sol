// SPDX-License-Identifier: MIT

pragma solidity ^0.8.23;

contract EmployeeStorage {
    uint32 salary;
    uint32 shares;
    uint256 public idNumber;
    string public name;

    constructor() {
        shares = 1000;
        name = "Pat";
        salary = 50000;
        idNumber = 112358132134;
    }

    function viewSalary () public view returns (uint32)  {
        return salary;
    }

    function viewShares () public view returns (uint32)  {
        return shares;
    }

    error TooManyShares (uint32 _shares);
    function grantShares (uint32 _newShares) public   {
        uint32 totalShares = shares + _newShares;
        if (totalShares > 5000) {
            revert TooManyShares(totalShares);
        }
        if (_newShares > 5000) {
            revert("Too many shares");
        }

        
        shares = totalShares;
    }

    function checkForPacking(uint _slot) public view returns (uint r) {
        assembly {
            r := sload (_slot)
        }
    }

    function debugResetShares() public {
        shares = 1000;
    }

}