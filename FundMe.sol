// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;
import {PriceConvert} from "./PriceConvert.sol";
contract FundMe{
        using PriceConvert for uint256;
    uint256 public  minimumUsd = 5 * 1e18;
    address[] public  funders;
    mapping (address funder => uint256 amountFunded) public addressToAmountFunded;
 function fund() public payable {

     require(msg.value.getConversionRate() >= minimumUsd, "didn't send enough ETH");
     funders.push(msg.sender);
     addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
 }

 
}