// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17; 

contract division{
    uint256 public finalNum ;
    function divisionTwoNum(uint256 a,uint256 b) external{
        finalNum = a / b ;
    }
}

interface Idivision{
    function divisionTwoNum(uint,uint) external;
    function finalNum () external pure returns(uint);
}

contract divisionCopy{
    function calldivisionTwoNum(uint x,uint y,address oldContractAddress) external{
        Idivision(oldContractAddress).divisionTwoNum(x,y);
    }
    function callgetFinalNum(address oldContractAddress) external pure returns(uint256){
        return Idivision(oldContractAddress).finalNum();
    }
}