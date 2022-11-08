// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17; 

contract Storage {
    address public owner = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    address public other = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
    
    function getOwnerBalance() public view returns (uint256) {
        return owner.balance;
    }

    // (2300 gas, throws error)
    // 現在的標準中盡量都沒有在使用transfer了
    // payable()是防呆用，若沒加上就不可.transfer() & .send()
    function sendValueByTransfer(address to) public {
        payable(to).transfer(15 ether);
    }

    // (2300 gas, returns bool)
    // 2300 gas 是因為轉帳只是改數字，不用改變數狀態等，不用耗費這麼多gas
    function sendValueTo(address to) public {
        bool sent = payable(to).send(15 ether);
        require(sent, "Failed to send Ether");
    }

    // call (forward all gas or set gas, returns bool)
    // 用call可以傳value or data給目標地址
    // 但EOA沒有合約的data，故可以轉錢給他且不給data
    function sendValueByCallTo(address to) public {
        (bool sent, bytes memory data) = to.call{value: 15 ether}("");
        require(sent, "Failed to send Ether");
    }

    receive() external payable {}
    fallback() external payable {}
}