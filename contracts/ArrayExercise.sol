// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

contract ArraysExercise {
    uint[] public numbers = [1,2,3,4,5,6,7,8,9,10];
    address[] senders;
    uint[] timestamps;

    function getNumbers() public view returns (uint[] memory) {
        return numbers;
    }

    function resetNumbers() public {
        for(uint i = 0; i < numbers.length; i++) {
            numbers[i] = i;   
        }
    }

    function appendToNumbers(uint[] calldata _toAppend) public {
        for(uint i = 0; i < _toAppend.length; i++) {
            numbers.push(_toAppend[i]);   
        }
    }

    function saveTimestamp(uint _unixTimestamp) public {
        address from = msg.sender;
        senders.push(from);
        timestamps.push(_unixTimestamp);
    }


    function _getNumberOfTimeStamps() private view returns(uint32) {
        uint32 numberOfTimestamps = 0;
        uint jan2000 = 946702800;
        for (uint32 i = 0; i < timestamps.length; i++) {
            if (timestamps[i] > jan2000) {
                numberOfTimestamps += 1;
            }
        }
        return numberOfTimestamps;
    }

    function afterY2K () public view returns (uint[] memory, address[] memory) {
        
        uint jan2000 = 946702800;
        uint numberOfTimeStamps = _getNumberOfTimeStamps();
        uint[] memory afterJan2000Timestamps = new uint[](numberOfTimeStamps);
        address[] memory afterJan2000Senders = new address[](numberOfTimeStamps);
        uint afterJan2000Index = 0;
        for (uint i = 0; i < timestamps.length; i++) {
            if (timestamps[i] > jan2000) {
                afterJan2000Timestamps[afterJan2000Index] = timestamps[i];
                afterJan2000Senders[afterJan2000Index] = senders[i];
                afterJan2000Index++;
            }
        }
        return (afterJan2000Timestamps, afterJan2000Senders);
    }

    function resetSenders () public {
        delete senders;
    }

    function resetTimestamps () public {
        delete timestamps;
    }

}

