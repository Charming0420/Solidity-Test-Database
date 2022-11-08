// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.8.4;

contract Struct {
    struct User {
        address id;
        string name;
    }

    User public owner;
    
    constructor() {
        //第一種賦值方法 最一般
        // owner = User(msg.sender, "KryptoCamp");
        
        //第二種賦值方法 最多程式語言使用方式
        // owner = User({
        //     id: msg.sender,
        //     name: "KryptoCamp"
        // });

        //第三種賦值方法 最無腦
        owner.id = msg.sender;
        owner.name = "KryptoCamp";
    }
    
    // function getOwnerAddress() public view returns (address) {
    //     return owner.id;
    // }
    
    // function getOwnerName() public view returns (string memory) {
    //     return owner.name;
    // }
}