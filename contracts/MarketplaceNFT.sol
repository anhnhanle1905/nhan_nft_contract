// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

contract Marketplace is Ownable {
    using Counters for Counters.Counter;
    using EnumerableSet for EnumerableSet.AddressSet;

    struct Order {
        address seller;
        address buyer;
        uint256 tokenId;
        address paymentToken;
        uint256 price;
    }
    Counters.Counter private _orderIdCount;
    // IERC721 public immutable nftContract;
    mapping(uint256 => Order) orders;
    uint256 public feeDecimal;
    uint256 public feeRate;
    address public feeRecipient;
    EnumerableSet.AddressSet private _supportedPaymentTokens;

    constructor() {}
}
