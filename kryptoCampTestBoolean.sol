// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17; 


contract testBoolean{

    bool public isActive  = true; 

    function changeActive () public 
    {
        if(isActive == false)
        {
            isActive = true;
        }
        else
        {
            isActive = false;
        }
    }

    function isActiveState () public view returns (bool)
    {
        return isActive;
    }
}