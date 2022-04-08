// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract TestNFT is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    uint256 public maxSupply = 10000;
    uint256 public maxMintAmountPerTx = 5;

    // event NftBought(address _seller, address _buyer, uint256 _price);
    // mapping (uint256 => uint256) public tokenIdToPrice;

    constructor() ERC721("TestNFT", "NFT") {}

    function _mint(address recipient, string memory tokenURI) public onlyOwner {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(recipient, newItemId);
        _setTokenURI(newItemId, tokenURI);
    }

    function mint(address recipient, string[] memory tokenURIs)
        public
        onlyOwner
    {
        for (uint256 i = 0; i < tokenURIs.length; i++) {
            _mint(recipient, tokenURIs[i]);
        }
    }

    function mintNFT(
        address recipient,
        string memory tokenURI,
        uint256 amount
    ) public onlyOwner {
        for (uint256 i = 0; i < amount; i++) {
            _mint(recipient, tokenURI);
        }
    }

    function transfer(
        address from,
        address to,
        uint256 tokenId
    ) public payable {
        _transfer(from, to, tokenId);
    }

    // function transfer2(
    //     address from,
    //     address to,
    //     uint256[] memory ids
    // ) public payable {
    //     _transfer2(from, to, ids);
    // }
}
