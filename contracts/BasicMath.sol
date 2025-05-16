// SPDX-License-Identifier: MIT

pragma solidity ^0.8.23;

contract BasicMath {
    function adder(uint _a, uint _b) external pure returns (uint sum, bool error) {
        uint max_uint = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
        if (_b > _a) {
            
            bool has_overflow = _b > 0 && _a > (max_uint - _b);
            if (has_overflow) {
                return (0, true);
            }
        }
        uint _c = _a + _b;
        if (_c > _a) {
            return (_c, false);
        }

        return (0, true);
    }

    function substractor(uint _a, uint _b) external pure returns (uint sum, bool error) {
        if (_b > 0 && _a < _b) {
            return (0, true);
        }
        
        if (_b > _a) {
             return (0, true);
        }
        uint _c = _a - _b;
        
        return (_c, false);
    }
}