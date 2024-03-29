// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Petty is ERC721, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCount;
    string private _baseTokenURI;

    constructor() ERC721("Petty", "PET") {}

    function mint(address to_) public onlyOwner returns (uint256) {
        _tokenIdCount.increment();
        uint256 _tokenId = _tokenIdCount.current();
        _mint(to_, _tokenId);
        return _tokenId;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    function updateBaseTokenURI(string memory baseTokenURI_) public onlyOwner {
        _baseTokenURI = baseTokenURI_;
    }
}
