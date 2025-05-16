// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;


contract ArrayDemo {
    uint[] public numbers;
    uint32 numEven;

    function getEvenNumbers() external view returns(uint[] memory) {
        uint32 numberOfEventNumbers = numEven;
        uint[] memory evenNumbers = new uint[](numberOfEventNumbers);
        uint32 evenNumbersIndex = 0;
        for (uint32 i = 0; i < numbers.length; i++) {
            if (numbers[i] % 2 == 0) {
                evenNumbers[evenNumbersIndex] = numbers[i];
                evenNumbersIndex += 1;
            }
        }
        return evenNumbers;
    }

    function _getNumberOfEvenNumbers() private view returns(uint32) {
        uint32 numberOfEvenNumbers = 0;
        for (uint32 i = 0; i < numbers.length; i++) {
            if (numbers[i] % 2 == 0) {
                numberOfEvenNumbers += 1;
            }
        }
        return numberOfEvenNumbers;
    }

    function debugLoadArray(uint _number) public {
        for (uint i = 0; i < _number; i++) {
            // if (i % 2 == 0) {
            //     numEven += 1;
            // }
            numbers.push(i);
        }
    }


}