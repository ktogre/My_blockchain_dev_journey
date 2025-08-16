// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract ChangeContractName {
    address public owner;
    string public contractName;

    event FallbackCalled(address sender, bytes data);
    event EtherReceived(address sender, uint256 amount);
    event NameChanged(string oldName, string newName);

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
}