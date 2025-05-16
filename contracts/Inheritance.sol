// SPDX-License-Identifier: MIT

pragma solidity ^0.8.23;



contract ContractB {
    function whoAmI() public virtual view returns (string memory) {
        return "contract B";
    }

    function whoAmIInternal() internal pure returns (string memory) {
        return "contract B";
    }
}

contract ContractC {
    function whoAmI() public virtual view returns (string memory) {
        return "contract C";
    }
}


abstract contract ContractD {
    function whoAreYou () public virtual view returns (string memory);
}

contract ContractA is ContractB, ContractC, ContractD {
    enum Type { None, ContractBType, ContractCType }

    Type contractType;

    constructor(Type _initialType) {
        contractType = _initialType;
    }

    function whoAmIExternal() external pure returns (string memory) {
        return whoAmIInternal();
    }

    function whoAmI() public override(ContractB, ContractC) view returns (string memory) {
        if(contractType == Type.ContractBType) {
            return ContractB.whoAmI();
        }
        if(contractType == Type.ContractCType) {
            return ContractC.whoAmI();
        }
        return "contract A";
    }
    function changeType(Type _newType) external {
        contractType = _newType;
    }

    function whoAreYou () public override pure returns (string memory) {
        return "contract D";
    }

}




