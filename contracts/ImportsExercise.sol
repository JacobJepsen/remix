// SPDX-License-Identifier: MIT

pragma solidity ^0.8.23;

library SillyStringUtils {

    struct Haiku {
        string line1;
        string line2;
        string line3;
    }

    function shruggie(string memory _input) internal pure returns (string memory) {
        return string.concat(_input, unicode" 🤷");
    }
}


contract ImportsExercise {
    using SillyStringUtils for SillyStringUtils.Haiku;

    SillyStringUtils.Haiku public haiku;

    function saveHaiku (string memory line1, string memory line2, string memory line3) public {
        haiku.line1 = line1;
        haiku.line2 = line2;
        haiku.line3 = line3;
    }

    function getHaiku () public view returns (SillyStringUtils.Haiku memory) {
        return haiku;
    }


    function shruggieHaiku  () public view returns (SillyStringUtils.Haiku memory) {
        return SillyStringUtils.Haiku({
            line1: haiku.line1,
            line2: haiku.line2,
            line3: SillyStringUtils.shruggie(haiku.line3)
        });

    }
    
}
