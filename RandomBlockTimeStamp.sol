// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

contract Random {
    function generateRandom() private view returns (uint256) {
        return uint256(
            keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp))
        );
    }
    
    function getAnswer() public view returns (uint256) {
        return generateRandom() % 1000;
    }
}