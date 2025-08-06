// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract BankAccessControl {
    address public owner;
    bool public paused = false;
    uint public totalDeposited;

    mapping(address => uint) public balances;

    event Deposits(address indexed sender, uint amount);
    event Withdrawals(address indexed owner, uint contractBalance);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Access Denied!. You're not the owner");
        _;
    }

    modifier whenNotPaused() {
        require(!paused, "Contract is paused, you can't deposit at the moment");
        _;
    }

    function deposit() external payable whenNotPaused {
        require(msg.value > 0, "Deposit amount must be greater than zero");
        balances[msg.sender] += msg.value;
        totalDeposited += msg.value;

        emit Deposits(msg.sender, msg.value);
    }

    function withdrawAllFunds() public onlyOwner {
        uint contractBalance = address(this).balance;
        require(contractBalance > 0, "Not enough funds!");
        payable(owner).transfer(contractBalance);

        emit Withdrawals(owner, contractBalance);
    }

    function togglePause() public onlyOwner {
        paused = !paused;
    }

    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }
}