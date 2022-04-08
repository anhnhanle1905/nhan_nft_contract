// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract TestNFT is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // event NftBought(address _seller, address _buyer, uint256 _price);
    // mapping(address => bool) public loanerNFT;
    // struct LoanData {
    //     uint256 tokenId;
    //     address loaner;
    // }
    struct TokenData {
        uint256 tokenId;
        address owner;
    }
    event NewLoanData(address indexed loaner, uint256 id);

    // LoanData[] public loanData;
    TokenData[] public tokenData;

    constructor() ERC721("TestNFT", "NFT") {}

    //mint function
    function _mint(address recipient, string memory tokenURI) public onlyOwner {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        tokenData.push(TokenData(newItemId, recipient));
        _mint(recipient, newItemId);
        _setTokenURI(newItemId, tokenURI);
    }

    // mint NFT with many URI
    function mint(address recipient, string[] memory tokenURIs)
        public
        onlyOwner
    {
        for (uint256 i = 0; i < tokenURIs.length; i++) {
            _mint(recipient, tokenURIs[i]);
        }
    }

    //mint NFT with amount
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

    // function loanNFT(address loaner, uint256 tokenId) public onlyOwner {
    //     addLoanerUser(tokenId, loaner);
    // }

    //add user loan

    // function addLoanerUser(uint256 tokenId, address _loaner) public onlyOwner {
    //     loanData.push(LoanData(tokenId, _loaner));
    // }

    // function removeLoanerUser(address _user) public onlyOwner {
    //     loanerNFT[_user] = false;
    // }

    function getTokenData() public view returns (TokenData[] memory) {
        return tokenData;
    }
    // function transfer2(
    //     address from,
    //     address to,
    //     uint256[] memory ids
    // ) public payable {
    //     _transfer2(from, to, ids);
    // }
}
