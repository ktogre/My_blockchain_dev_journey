// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract SimpleDonationBox {
    address public recipient;
    uint public totalDonated;
    mapping(address => uint) public balances;

    event DonationReceived(address indexed donor, uint fund);
    event FundsWithdrawn(address indexed recipient, uint contractBalance);

    constructor() {
        recipient = msg.sender;
    }

    function donateFunds() public payable {
        require(msg.value > 0, "You must send some ether");
        balances[msg.sender] += msg.value;
        totalDonated += msg.value;

        emit DonationReceived(msg.sender, msg.value);
    }

    function withdrawAllFunds() public {
        require(msg.sender == recipient, "Only recipient can withdraw funds");
        uint contractBalance = address(this).balance;
        require(contractBalance > 0, "No funds to withdraw");
        
        
        payable(recipient).transfer(contractBalance);
        emit FundsWithdrawn(recipient, contractBalance);
    }

    function getMyDonation() public view returns (uint) {
        return balances[msg.sender];
    }
}