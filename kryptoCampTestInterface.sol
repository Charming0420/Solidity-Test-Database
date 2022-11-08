// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract Counter {
    uint256 public count;
    
    function inc() external {
        count += 1;
    }
}

interface ICounter {
    function count() external view returns (uint256);
    function inc() external;
}


//總而言之 先寫好Interface (不需要部屬)
//部署一個新合約
//就可以利用 「 接口名稱(舊合約地址).舊合約方法() 」來去調用舊合約的function
//E.x interfaceName(wannaCallContractAddress).wannaCallFunction()

contract Interface { 
    function incCounter(address _counter) external {
        ICounter(_counter).inc();
    }
    
    function getCount(address _counter) external view returns (uint256) {
        return ICounter(_counter).count();
    }
}

//抽象合約可以拿來被繼承然後去完善去實作 去override
