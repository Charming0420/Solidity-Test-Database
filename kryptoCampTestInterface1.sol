// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract testCon1{
    uint256 num;

    function addNum() external 
    {
        num+=1;
    }

    function getNum() external view returns(uint256){
        return num;
    }
}

interface ItestCon1{
    function addNum() external;
    function getNum() external view returns(uint256);
}

contract callWannaContract{
    function addNumToWannaCallFunction (address oldContractAdd) external
    {
        ItestCon1(oldContractAdd).addNum();
    }

    function getNumTowannaCallFunction (address oldContractAdd) external view returns(uint256)
    {
        return ItestCon1(oldContractAdd).getNum();
    }
}