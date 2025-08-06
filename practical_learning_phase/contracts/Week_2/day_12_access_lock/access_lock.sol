// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract AccessLock {
    address public owner;
    bool public locked;

    constructor() {
        owner = msg.sender;
        locked = false;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You're not the owner, only the owner can lock or unlock");
        _;
    }

    modifier onlyWhenUnlocked() {
        if (locked) {
            revert("Function is locked");
        }
        _;
    }

    function lock() public onlyOwner {
        locked = true;
    }

    function unlock() public onlyOwner {
        locked = false;
    }

    function doSomething() public view onlyWhenUnlocked returns (string memory) {
        return "Executed successfully!";
    }
}
