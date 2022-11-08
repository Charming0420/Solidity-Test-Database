// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17; 


contract testConstruct {
    uint32 public ballsNumber;
    
    constructor (uint32 ballsNum){
        ballsNumber = ballsNum;
    }

}