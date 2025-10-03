// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract ChangeContractName {
    address public owner;
    string public contractName;

    event FallbackCalled(address sender, bytes data);
    event EtherReceived(address sender, uint256 amount);
    event NameChanged(string oldName, string newName);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event FundsWithdrawn(address indexed to, uint256 amount);

    constructor(string memory _name) {
        owner = msg.sender;
        contractName = _name;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    receive() external payable {
        emit EtherReceived(msg.sender, msg.value);
    }

    fallback() external payable {
        emit FallbackCalled(msg.sender, msg.data);
    }

    function resetName(string memory _newName) public onlyOwner {
        emit NameChanged(contractName, _newName);
        contractName = _newName;
    }

    function withdrawFunds(uint256 _amount) public onlyOwner {
        require(address(this).balance >= _amount, "Insufficient balance");
        payable(owner).transfer(_amount);
        emit FundsWithdrawn(owner, _amount);
    }

    function transferOwnership(address _newOwner) public onlyOwner {
        require(_newOwner != address(0), "Invalid address");
        _newOwner = msg.sender;
        owner = _newOwner;
        
        emit OwnershipTransferred(owner, _newOwner);
    }
}