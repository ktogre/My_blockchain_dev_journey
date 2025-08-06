// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract AutoRejector {
    address public owner;

    mapping(address => uint) public balances;

    event EtherReceivedByOwner(address indexed sender, uint256 amount);
    event EtherRejected(address indexed sender, uint256 amount);
    event EtherDeposited(address indexed sender, uint256 amount);
    event EtherWithdrawn(address indexed sender, uint256 amount);

    error OnlyOwnerCanSendETH();
    error OnlyOwnerCanWithdraw();

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {
        if (msg.sender != owner) {
            emit EtherRejected(msg.sender, msg.value);
            revert OnlyOwnerCanSendETH();
        }
        emit EtherReceivedByOwner(msg.sender, msg.value);
    }

    function deposit() external payable onlyOwner {
        require(msg.value > 0, "Deposit amount must be greater than 0");
        balances[msg.sender] += msg.value;
        emit EtherDeposited(msg.sender, msg.value);
    }

    function withdraw(uint amount) external onlyOwner {
        require(amount <= address(this).balance, "Insufficient balance");
        payable(owner).transfer(amount);
        emit EtherWithdrawn(owner, amount);
    }

    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}