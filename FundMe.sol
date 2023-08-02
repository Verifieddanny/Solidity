// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;


import {PriceConvert} from "./PriceConvert.sol";

 error NotOwner();

contract FundMe{
        using PriceConvert for uint256;
   
   
    uint256 public constant  MINIMUM_USD = 5 * 1e18;
  
  
    address[] public  funders;
   
   
    mapping (address funder => uint256 amountFunded) public addressToAmountFunded;
   
   
    address public immutable i_owner;


    constructor(){
        i_owner = msg.sender;
    }

 function fund() public payable {

     require(msg.value.getConversionRate() >= MINIMUM_USD, "didn't send enough ETH");
     funders.push(msg.sender);
     addressToAmountFunded[msg.sender] += msg.value;
 }


 function withdraw() public onlyOwner{



    //  for(/* starting index, ending index, step amount */)
    for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex ++){
        address funder = funders[funderIndex];
        addressToAmountFunded[funder] = 0;
    }


    funders = new address[](0);

    //transfer, send and call are type of sending ether

    // transfer:
    //payable(msg.sender) = payable address 
    // payable (msg.sender).transfer(address(this).balance);

    //send:
    // bool sendSuccess = payable(msg.sender).send(address(this).balance);
    // require(sendSuccess, "Send Failed");

    //Call:
    // (bool callSuccess, bytes memory dataReturned) =   payable (msg.sender).call{value: address(this).balance}("")
 (bool callSuccess, ) =   payable (msg.sender).call{value: address(this).balance}("");
    require(callSuccess, "Call failed");
 }

 modifier onlyOwner(){
        //   require(msg.sender == i_owner, "Must be Owner");
          if(msg.sender != i_owner){ revert NotOwner();}
          _;
 }

//  Special Functions: Recieve and Fallback
  receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}