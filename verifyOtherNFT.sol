// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17; 


import "@openzeppelin/contracts/interfaces/IERC721.sol";

contract Example {

  function walletHoldsToken(address _wallet, address _contract) public view returns (bool) {
    return IERC721(_contract).balanceOf(_wallet) > 0 ;
  }
}