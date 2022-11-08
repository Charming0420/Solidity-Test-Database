// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17; 

contract NFTmint{

    mapping(uint256 => address) public NFT;
    uint counter = 0;

    function Mintnft() external{
        NFT[counter]=msg.sender;
        counter+=1;
    }
}