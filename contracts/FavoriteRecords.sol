// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;


contract FavoriteRecords {
    string[] public approvedRecordNames;
    mapping(string => bool) public approvedRecords;
    mapping(address => mapping(string => bool)) public userFavorites;

    constructor() {
        _addApprovedRecord("Thriller");
        _addApprovedRecord("Back in Black");
        _addApprovedRecord("The Bodyguard");
        _addApprovedRecord("The Dark Side of the Moon");
        _addApprovedRecord("Their Greatest Hits (1971-1975)");
        _addApprovedRecord("Hotel California");
        _addApprovedRecord("Come On Over");
        _addApprovedRecord("Rumours");
        _addApprovedRecord("Saturday Night Fever");
    }

    function _addApprovedRecord(string memory _approvedRecord) private {
        approvedRecordNames.push(_approvedRecord);
        approvedRecords[_approvedRecord] = true;
    }

    function getApprovedRecords() public view returns (string[] memory){
        return approvedRecordNames;
    }

    error NotApproved(string _recordName);
    function addRecord(string memory _recordName) public {

        
        bool isApprovedRecordName = approvedRecords[_recordName];
        if (isApprovedRecordName) {
            userFavorites[msg.sender][_recordName] = true;
        }
        else {
            revert NotApproved(_recordName);
        }

    }

    function getUserFavorites(address _address) public view returns (string[] memory) {
       
        uint addressUserFavoritesSize = 0;
        for (uint i = 0; i < approvedRecordNames.length; i++) {
            string memory approvedRecord = approvedRecordNames[i];
            if (userFavorites[_address][approvedRecord]) {
                addressUserFavoritesSize += 1;
            }
        }

        string[] memory addressUserFavorites = new string[](addressUserFavoritesSize);
        uint addressUserFavoritesIndex = 0;
        for (uint i = 0; i < approvedRecordNames.length; i++) {
            string memory approvedRecord = approvedRecordNames[i];
            if (userFavorites[_address][approvedRecord]) {
                addressUserFavorites[addressUserFavoritesIndex] = approvedRecord;
                addressUserFavoritesIndex += 1;
            }
        }
        return addressUserFavorites;
    }

    function resetUserFavorites() public {
        for (uint i = 0; i < approvedRecordNames.length; i++) {
            string memory approvedRecord = approvedRecordNames[i];
            userFavorites[msg.sender][approvedRecord] = false;
        }
    }

}