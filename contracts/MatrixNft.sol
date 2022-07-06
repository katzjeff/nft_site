// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract MatrixNft is ERC721, Ownable {
    uint256 public mintPrice;
    uint256 public totalSupply;
    uint256 public maxSupply;
    uint256 public maxPerWallet;
    bool public isPublicMintEnabled;
    string internal baseTokenUri;
    address payable public withdrawableWallet;
    mapping(addres => uint256) public walletMints;

    constructor() payable ERC721 ("MatrixNft", "MN") {
        mintPrice = 0.02 ether;
        totalSupply = 0;
        maxSupply = 10000;
        maxPerWallet = 3;
        //set withdraw wallet 
        //withdrawableWallet = "Enter your address here" 
    }

    function setIsPublicMintEnabled (bool isPublicMintEnabled_) external onlyOwner {
        isPublicMintEnabled = isPublicMintEnabled_;
    }

    function setBaseTokenUri(string calldata baseTokenUri_) external onlyOwner {
        baseTokenUri = baseTokenUri_;
    }

    function tokenURI(uint256 tokenId_) public view override returns (string memory) {
       require (_exists(tokenId_), 'Token does not exists!');
       return string(abi.encodePacked(baseTokenUri, Strings.toString(tokenId_), ".json")); 
    }

    function withdraw() external onlyOwner {
        (bool success, ) = withdrawWallet.call{value: address(this).balance}('');
        require(success, 'withdraw failed');
    }


}
