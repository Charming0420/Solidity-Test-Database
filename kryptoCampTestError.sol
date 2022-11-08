// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

/// Not enough funds for transfer. Requested `requested`,
/// but only `available` available. 
error NotEnoughFunds(string); //0.8.4後新的寫法

contract OtherContract {
    function wrongFunction() external {
        revert();
    }
}

contract ErrorControl {
    mapping(address => uint) balances;
    OtherContract public otherContract;

    constructor() {
        otherContract = new OtherContract();
    }

    function transferThrowError() public {
        revert();
        // throw;
    }
    
    function transferAssertError() public {
        assert(true); // true
        //.. ->> xx
        //.. ->> xx
    }
    
    function transferRevertError() public {
        revert NotEnoughFunds("Not enough money!!!");
    }
    
    function requireRevertError() public {
        require(true, "revert error!!!!!");
    }

    function tryCatchError() public returns (string memory) {
        try otherContract.wrongFunction() {
        } catch {
            return "Something wrong!!";
        }
    }
}