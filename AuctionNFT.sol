// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract KryptoToy is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("KryptoToy", "KT") {}

    function mint(address to) public {
        uint256 tokenId = _tokenIds.current();
        _mint(to, tokenId);

        _tokenIds.increment();
    }
    struct Auction {
    uint256 startTime;
    uint256 timeStep;
    uint256 startPrice;
    uint256 endPrice;
    uint256 priceStep;
    uint256 stepNumber;
}

    Auction public auction;

// "50000000000000000" -> 0.05 ether
    function getAuctionPrice() public view returns (uint256) {
        Auction memory currentAuction = auction;
        if (block.timestamp < currentAuction.startTime) {
            return currentAuction.startPrice;
    }
    uint256 step = (block.timestamp - currentAuction.startTime) /
        currentAuction.timeStep;
    if (step > currentAuction.stepNumber) {
        step = currentAuction.stepNumber;
    }
    return
        currentAuction.startPrice > step * currentAuction.priceStep
            ? currentAuction.startPrice - step * currentAuction.priceStep
            : currentAuction.endPrice;
    }   

    function setAuction(
        uint256 _startTime,
        uint256 _timeStep,
        uint256 _startPrice,
        uint256 _endPrice,
        uint256 _priceStep,
        uint256 _stepNumber
    ) public  {
        auction.startTime = _startTime; // 開始時間
        auction.timeStep = _timeStep; // 5 多久扣一次
        auction.startPrice = _startPrice; // 50000000000000000 起始金額
        auction.endPrice = _endPrice; // 10000000000000000 最後金額
        auction.priceStep = _priceStep; // 10000000000000000 每次扣除多少金額
        auction.stepNumber = _stepNumber; // 5 幾個階段
    }

    function auctionMint() external payable {
        require(msg.value >= getAuctionPrice(), "not enough value");
        uint256 tokenId = _tokenIds.current();
        _mint(msg.sender, tokenId);
        _tokenIds.increment();
    }
}