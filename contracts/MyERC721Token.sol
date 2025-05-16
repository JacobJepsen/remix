// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MyERC721Token is ERC721 {
    uint256 public counter;

    string constant BAYC = "https://ipfs.io/ipfs/QmeSjSinHpPnmXmspMjwiXyN6zS4E9zccariGR3jxcaWtq/";
    string constant DOODLES = "https://ipfs.io/ipfs/QmPMc4tcBsMqLRuCQtPmPe84bpSjrC3Ky7t3JWuHXYB4aS/";

    enum NFTMetadata { BAYC, DOODLES }
    NFTMetadata nftMetadata = NFTMetadata.BAYC;

    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {
        counter = 1;
    }

    function redeemNTF() external {
        _safeMint(msg.sender, counter);
        counter += 1;
    }

    function _baseURI() internal override view returns(string memory) {
        if (nftMetadata == NFTMetadata.BAYC) {
            return BAYC;
        } else if (nftMetadata == NFTMetadata.DOODLES){
            return DOODLES;
        } else {
            revert("Error...");
        }
    }

    function switchURI() public {
        // TODO: Limit to contract owner
        nftMetadata = nftMetadata == NFTMetadata.BAYC ? NFTMetadata.DOODLES : NFTMetadata.BAYC;
    }

}

