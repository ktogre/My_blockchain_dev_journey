// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Wallet {
    address public owner;
    uint public totalDeposited;
    uint public constant DEPOSIT_LIMIT = 1 ether; // Set the deposit limit to 1 ether per transaction

    event Deposited(address indexed sender, uint amount);
    event Withdrawn(address indexed recipient, uint amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function deposit() public payable {
        require(msg.value > 0, "Must send ether to deposit");
        require(msg.value <= DEPOSIT_LIMIT, "Deposit amount exceeds the limit");
        totalDeposited += msg.value;

        emit Deposited(msg.sender, msg.value);
    }

    function withdraw(uint _amount) public onlyOwner {
        require(_amount > 0, "Must withdraw a positive amount");
        require(address(this).balance >= _amount, "Insufficient balance");

        payable(owner).transfer(_amount);
        emit Withdrawn(owner, _amount);
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}