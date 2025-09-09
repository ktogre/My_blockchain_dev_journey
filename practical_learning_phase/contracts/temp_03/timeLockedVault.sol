// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract TimeLockedVault {
    address public owner;
    uint256 public unlockTime;
    uint256 public newUnlockTime;
    uint256 public totalDeposited;
    uint256 public totalWithdrawn;

    event Deposits(address indexed sender, address indexed receiver, uint256 amount);
    event Withdrawals(address indexed from, uint amount);
    event LockExtended(uint256 oldUnlockTime, uint256 newUnlockTime);

    constructor(uint256 _lockedDuration) {
        owner = msg.sender;
        unlockTime = block.timestamp + _lockedDuration;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function deposit() external payable {
        require(msg.value > 0, "Must deposit ETH");
        totalDeposited += msg.value;

        emit Deposits(msg.sender, owner, msg.value);
    }

    function withdraw(uint256 amount) external onlyOwner {
        require(block.timestamp >= unlockTime, "Not time to widthdraw");
        require(amount > 0, "Not enough ether");
        totalDeposited -= amount;
        totalWithdrawn += amount;
        payable(owner).transfer(amount);

        emit Withdrawals(owner, amount);
    }

    function extendUnlockTime(uint256 _lockDuration) external onlyOwner {
        newUnlockTime = block.timestamp + _lockDuration;
        require(newUnlockTime > unlockTime, "New lock duration must be greater than old one");
        unlockTime = newUnlockTime;
        emit LockExtended(unlockTime, newUnlockTime);
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}