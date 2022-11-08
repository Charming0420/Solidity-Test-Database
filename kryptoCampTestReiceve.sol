// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract Receive {

    uint256 public balance = address(this).balance;
    // event ReceiveLog(string);

    // function buybool() public {
    //     payable(接收方地址).transfer(1 ether);
    // }

    // receive() external payable {
    //     emit ReceiveLog("[001]receive ether...");
    // }
    // mapping(address=>uint256) public balanceOf ;
    receive() external payable {
        balance+=msg.value;
    }
}