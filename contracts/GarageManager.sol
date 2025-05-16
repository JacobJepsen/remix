// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;


contract GarageManager {
    mapping(address => Car[]) public garage;
    



    struct Car {
        string make;
        string model;
        string color;
        uint8 numberOfDoors;
    }


    function addCar(string memory _make, string memory _model, string memory _color, uint8 _numberOfDoors) public {

        Car memory newCar = Car({
                make: _make,
                model: _model,
                color: _color,
                numberOfDoors: _numberOfDoors
            });
        Car[] storage currentCars = garage[msg.sender];
        currentCars.push(newCar);
    }

    function getMyCars() public view returns(Car[] memory) {

        Car[] memory callersCars = garage[msg.sender];

        return callersCars;
    }

    function getUsersCars(address _address) public view returns(Car[] memory) {

        Car[] memory callersCars = garage[_address];

        return callersCars;
    }

    error BadCarIndex(uint _index);

    function updateCar(uint _index, string memory _make, string memory _model, string memory _color, uint8 _numberOfDoors) public {

        
        Car[] storage callersCars = garage[msg.sender];
        if (_index < callersCars.length) {

            Car memory car = callersCars[_index];
            car.make = _make;
            car.model = _model;
            car.color = _color;
            car.numberOfDoors = _numberOfDoors;
            callersCars[_index] = car;
            garage[msg.sender] = callersCars;
        }
        else {
            revert BadCarIndex(_index);
        }
    }

    function resetMyGarage() public {

        delete garage[msg.sender];

    }

}