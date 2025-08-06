// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Wallet {
    address public owner;
    uint public totalDeposited;

    event Deposited(address indexed sender, uint amount);

    constructor() {
        owner = msg.sender;
    }

    function deposit() public payable {
        require(msg.value > 0, "Must send ether to deposit");
        totalDeposited += msg.value;

        emit Deposited(msg.sender, msg.value);
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}