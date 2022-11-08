// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

abstract contract Feline {
    function utterance() public pure virtual returns (string memory);
    function dogwoof() public pure virtual returns (string memory);
}

contract Cat is Feline {
    function utterance() public pure override returns (string memory) {
        return "miaow";
    }
    function dogwoof() public pure override returns (string memory){
        return "woof!!!";
    }
}