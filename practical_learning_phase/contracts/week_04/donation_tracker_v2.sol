// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract DonationTracker {
    address public owner;
    mapping(address => uint) public donations;

    event DonationsReceived(address indexed from, uint amount);
    event DonationsWithdrawn(address indexed to, uint amount);

    uint public constant MIN_DONATION = 0.001 ether;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    // Receive donations with minimum check
    receive() external payable {
        require(msg.value >= MIN_DONATION, "Donation too small");
        donations[msg.sender] += msg.value;
        emit DonationsReceived(msg.sender, msg.value);
    }

    // Fallback for non-empty calldata
    fallback() external payable {
        require(msg.value >= MIN_DONATION, "Donation too small");
        donations[msg.sender] += msg.value;
        emit DonationsReceived(msg.sender, msg.value);
    }

    // Check total donations in the contract
    function getTotalDonations() public view returns (uint) {
        return address(this).balance;
    }

    // Check donations of caller
    function getMyDonations() public view returns (uint) {
        return donations[msg.sender];
    }

    // Withdraw all funds to owner
    function withdraw() public onlyOwner {
        uint amount = address(this).balance;
        (bool sent, ) = payable(owner).call{value: amount}("");
        require(sent, "Transfer failed");
        emit DonationsWithdrawn(owner, amount);
    }

    // Withdraw all funds to a specific address
    function withdrawTo(address _to) public onlyOwner {
        require(_to != address(0), "Invalid address");
        uint amount = address(this).balance;
        (bool sent, ) = payable(_to).call{value: amount}("");
        require(sent, "Transfer failed");
        emit DonationsWithdrawn(_to, amount);
    }

    // Transfer ownership
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Invalid address");
        owner = newOwner;
    }

    // Renounce ownership
    function renounceOwnership() public onlyOwner {
        owner = address(0);
    }
}
