// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.8.4;

contract Enum {
    enum Rarity {
        original, // 0
        rare, // 1
        super_rare // 2
    }

    Rarity public rarity;

    constructor() {
        rarity = Rarity.original;
    }

    function makeSuperRare() public {
        rarity = Rarity.super_rare;
    }

    function reset() public {
        delete rarity;
    }

    function watchRarity () public view returns(string memory){ //如果要顯示字串的方法
        if(rarity==Rarity.original)
        {
            return "original";
        }
        else if(rarity==Rarity.rare)
        {
            return "rare";
        }
        else
        {
            return "super_rare";
        }
    }
}