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
    IERC721 public immutable nftContract;
    mapping(uint256 => Order) orders;
    uint256 public feeDecimal;
    uint256 public feeRate;
    address public feeRecipient; //fee để trả cho ng mua
    EnumerableSet.AddressSet private _supportedPaymentTokens; // giúp marketplace có thể chấp nhận thanh toán bằng nhiều loại erc20 khác nhau
    event OrderAdded(
        uint256 indexed orderId,
        address indexed seller,
        uint256 indexed tokenId,
        address paymentToken,
        uint256 price
    );
    event OrderCancelled(uint256 indexed orderId);
    event OrderMatched(
        uint256 indexed orderId,
        address indexed seller,
        address indexed buyer,
        uint256 tokenId,
        address paymentToken,
        uint256 price
    );
    event FeeRateUpdated(uint256 feeDecimal, uint256 feeRate);

    constructor(
        address nftAddress_,
        uint256 feeDecimal_,
        uint256 feeRate_,
        address feeRecipient_
    ) {
        require(
            nftAddress_ != address(0),
            "NFTMarketplace: nftAddress_ is zero address"
        );

        nftContract = IERC721(nftAddress_);
        _updateFeeRecipient(feeRecipient_);
        _updateFeeRate(feeDecimal_, feeRate_);
        _orderIdCount.increment();
    }

    function _updateFeeRecipient(address feeRecipient_) internal {
        require(
            feeRecipient_ != address(0),
            "NFTMarketplace: feeRecipient_ is zero address"
        );
        feeRecipient = feeRecipient_;
    }

    function updateFeeRecipient(address feeRecipient_) external onlyOwner {
        _updateFeeRecipient(feeRecipient_);
    }

    function _updateFeeRate(uint256 feeDecimal_, uint256 feeRate_) internal {
        require(
            feeRate_ < 10**(feeDecimal_ + 2),
            "NFTMarketplace: bad fee rate"
        );
        feeDecimal = feeDecimal_;
        feeRate = feeRate_;
        emit FeeRateUpdated(feeDecimal_, feeRate_);
    }

    function updateFeeRate(uint256 feeDecimal_, uint256 feeRate_)
        external
        onlyOwner
    {
        _updateFeeRate(feeDecimal_, feeRate_);
    }

    function _calculateFee(uint256 orderId_) private view returns (uint256) {
        Order storage _order = orders[orderId_];
        if (feeRate == 0) {
            return 0;
        }
        return (feeRate * _order.price) / 10**(feeDecimal + 2);
    }

    function isSeller(uint256 orderId_, address seller_)
        public
        view
        returns (bool)
    {
        return orders[orderId_].seller == seller_;
    }

    function addPaymentToken(address paymentToken_) external onlyOwner {
        require(
            paymentToken_ != address(0),
            "NFTMarketplace: feeRecipient_ is zero address"
        );
        require(
            _supportedPaymentTokens.add(paymentToken_),
            "NFTMarketplace: already supported"
        );
    }

    function isPaymentTokenSupported(address paymentToken_)
        public
        view
        returns (bool)
    {
        return _supportedPaymentTokens.contains(paymentToken_);
    }

    modifier onlySupportedPaymentToken(address paymentToken_) {
        require(
            isPaymentTokenSupported(paymentToken_),
            "NFTMarketplace: unsupport payment token"
        );
        _;
    }
}
