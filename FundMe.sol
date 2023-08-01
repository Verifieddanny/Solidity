// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract FundMe{

    uint256 public  minimumUsd = 5;
 function fund() public payable {

     require(msg.value >= minimumUsd, "didn't send enough ETH");
 }

 function getPrice() public {
     //Address (0x694AA1769357215DE4FAC081bf1f309aDC325306)
     // and ABI

 }
 function getConversionRate() public {}
}