// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract AccessLock {
    address public owner;
    bool public locked;

    event Locked(address indexed by);
    event Unlocked(address indexed by);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    
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
        emit Locked(msg.sender);
    }

    function unlock() public onlyOwner {
        locked = false;
        emit Unlocked(msg.sender);
    }

    function transferOwnership(address _newOwner) public onlyOwner {
        require(_newOwner != address(0), "Invalid address");
        _newOwner = msg.sender;
        owner = _newOwner;

        emit OwnershipTransferred(owner, _newOwner);
    }

    function doSomething() public view onlyWhenUnlocked returns (string memory) {
        return "Executed successfully!";
    }
}