// SPDX-License-Identifier: MIT

pragma solidity ^0.8.23;

contract Errors {
    function compilerConversionErrorFixed() public pure returns (uint) {
        int8 first = 1;

        return uint(uint8(first));
    }

    function compilerOperatorErrorFixed() public pure returns (uint) {
        int8 first = 1;
        uint256 second = 2;

        uint sum = uint(uint8(first)) + second;

        return sum;
    }

    function stackDepthLimitFixed() public pure returns (uint) {
        uint subtotalA;
        {
            uint first = 1;
            uint second = 2;
            uint third = 3;
            uint fourth = 4;
            uint fifth = 5;
            uint sixth = 6;
            uint seventh = 7;
            uint eighth = 8;
            subtotalA = first +
                second +
                third +
                fourth +
                fifth +
                sixth +
                seventh +
                eighth;
        }

        uint subtotalB;
        {
            uint ninth = 9;
            uint tenth = 10;
            uint eleventh = 11;
            uint twelfth = 12;
            uint thirteenth = 13;
            uint fourteenth = 14;
            uint fifteenth = 15;
            uint sixteenth = 16;
            subtotalB = ninth +
                tenth +
                eleventh +
                twelfth +
                thirteenth +
                fourteenth +
                fifteenth +
                sixteenth;
        }

        return subtotalA + subtotalB;
    }

    function badGetLastValue() public pure returns (uint) {
        uint[4] memory arr = [uint(1), 2, 3, 4];

        return arr[arr.length-1];
    }

    function badRandomLoop() public view returns (uint) {
        uint seed = 0;
        // DO NOT USE THIS METHOD FOR RANDOM NUMBERS!!! IT IS EASILY EXPLOITABLE!!!
        while(uint(keccak256(abi.encodePacked(block.timestamp, seed))) % 1000 != 0) {
            seed++;
            // ...do something
        }

        return seed;
    }
    function badSubtraction() public pure returns (uint) {
        uint first = 1;
        uint second = 2;
        return first - second;
    }
    function badSubstractionFixed() public pure returns (int) {
        int first = 1;
        int second = 2;
        return first - second;
    }

    function badDivision() public pure returns (uint) {
        uint first = 1;
        uint second = 0;
        return first / second;
    }

}