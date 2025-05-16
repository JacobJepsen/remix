// SPDX-License-Identifier: MIT

pragma solidity ^0.8.23;
import {Ownable} from "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";


contract AddressBook is Ownable {
    struct Contact {
        uint id;
        string firstName;
        string lastName;
        uint[] phoneNumbers;
    }


    uint[] knownContactIds;
    mapping(uint => Contact) public contacts;

    error ContactNotFound(uint _id);

    constructor(address initialOwner) Ownable(initialOwner) {

    }
    
    function addContact(uint _id, string memory _firstName, string memory _lastName, uint[] memory _phoneNumbers) public onlyOwner {
        Contact memory newContact = Contact({
            id: _id,
            firstName: _firstName,
            lastName: _lastName,
            phoneNumbers: _phoneNumbers
        });
        contacts[_id] = newContact;
        bool isIdKnown = false;
        for(uint i = 0; i < knownContactIds.length; i++) {
            if (knownContactIds[i] == _id) {
                isIdKnown = true;
            }
        }
        if (!isIdKnown) {
            knownContactIds.push(_id);
        }
    }

    function deleteContact(uint _id) public onlyOwner {
        bool isIdKnown = false;
        uint indexOfValue = 0;
        for(uint i = 0; i < knownContactIds.length; i++) {
            if (knownContactIds[i] == _id) {
                isIdKnown = true;
            }
        }
        if (!isIdKnown) {
            revert ContactNotFound(_id);
        }
        delete knownContactIds[indexOfValue];
        delete contacts[_id];
    }

    function getContact(uint _id) public view returns (Contact memory)  {

        bool isIdKnown = false;
        for(uint i = 0; i < knownContactIds.length; i++) {
            if (knownContactIds[i] == _id) {
                isIdKnown = true;
            }
        }
        if (!isIdKnown) {
            revert ContactNotFound(_id);
        }
        return contacts[_id];
    }

   function getAllContacts() public view returns (Contact[] memory)  {
        
        uint numberOfContacts = 0;
        for(uint i = 0; i < knownContactIds.length; i++) {
            if (knownContactIds[i] != 0) {
                numberOfContacts += 1;
            }
        }
        Contact[] memory currentContacts = new Contact[](numberOfContacts);
        uint contactsIndex = 0;
        for(uint i = 0; i < knownContactIds.length; i++) {
            if (knownContactIds[i] != 0) {
                currentContacts[contactsIndex] = contacts[knownContactIds[i]];
                contactsIndex += 1;
            }
        }
        return currentContacts;
   } 

}



contract AddressBookFactory {
    function CreateAddressBook () public returns (address) {
        AddressBook addressBook = new AddressBook(msg.sender);
        return address(addressBook);
    }
}

