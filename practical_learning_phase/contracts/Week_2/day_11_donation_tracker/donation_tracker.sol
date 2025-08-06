// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract DonationTracker {
    address public owner;
    mapping(address => uint) public donations;

    event DonationsRecieved(address indexed from, uint amount);
    event DonationsWithdrawn(address indexed to, uint amount);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    receive() external payable {
        donations[msg.sender] += msg.value;
        emit DonationsRecieved(msg.sender, msg.value);
    }

    function withdraw() public onlyOwner {
        uint amount = address(this).balance;
        payable(owner).transfer(amount);
        emit DonationsWithdrawn(owner, amount);
    }
}