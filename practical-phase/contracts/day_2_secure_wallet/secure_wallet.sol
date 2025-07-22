// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract SecureWallet {
    address public owner;
    mapping (address => uint) public balances;


    event Deposits(address indexed sender, uint amount);
    event Withdrawals(address indexed receiver, uint amount);


    constructor() {
        owner = msg.sender; 
    }

    function deposit() public payable {
        require(msg.value > 0, "Deposit must be greater than zero");
        balances[msg.sender] += msg.value;


        emit Deposits(msg.sender, msg.value);
    }

    function withdraw(uint amount) public {
        require(address(this).balance >= amount, "Insufficient balance");
        require(msg.sender == owner, "Only owner can withdraw");

        payable(msg.sender).transfer(amount);

        emit Withdrawals(msg.sender, amount);
    }

    function getContractBalance() public view returns(uint) {
        return address(this).balance;  
    }
       receive() external payable {
        balances[msg.sender] += msg.value;
    }
}