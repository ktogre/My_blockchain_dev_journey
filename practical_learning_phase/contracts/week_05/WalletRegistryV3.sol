// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

/// @title WalletRegistryV3
/// @notice Users can register a unique username and link it to their Ethereum address.
/// @dev Extends V2 by adding ownership transfer and time based registration
/// @author ktogre

contract WalletRegistryV3 {

    address public owner;
    bool paused;
    bool ended;
    uint256 registrationTime;
    uint256 newRegistrationTime;

    enum ContractState {Active, Paused, Ended}

    event WalletRegistered(address indexed user, string userName);
    event OwnerShipTransfer(address indexed owner, address indexed newOwner);

    constructor(uint256 _registrationDuration) {
        owner = msg.sender;
        registrationTime = block.timestamp + _registrationDuration;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    modifier onlyWhenNotPaused() {
        require(!paused, "Registration is paused at the moment");
        _;
    }

    modifier onlyWhenNotEnded() {
        require(!ended, "Registration has ended");
        _;
    }

    struct User {
        string userName;
        address user; 
    }

    User[] public listOfUsers;

    mapping(string => address) userNameToAddress;

    // allows users to register their wallet address to a unique username
    function registerWalletAddress(string memory _userName, address _user) public onlyWhenNotPaused onlyWhenNotEnded {
        require(block.timestamp <= registrationTime, "Registration has ended");
        require(userNameToAddress[_userName] == address(0), "Username already taken");
        listOfUsers.push(User(_userName, _user));
        userNameToAddress[_userName] = _user;

        emit WalletRegistered(_user, _userName);
    }

    function togglePause() public onlyOwner {
        paused = !paused;
    }

    //
    function checkContractState() public view returns (ContractState) {
        if (ended == true) {
            return ContractState.Ended;
        } else if (paused == true) {
            return ContractState.Paused;
        } else {
            return ContractState.Active;
        }
    }

    // 
    function transferOwnerShip(address _newOwner) public onlyOwner {
        require(_newOwner != address(0), "Invalid owner address");
        owner = _newOwner;

        emit OwnerShipTransfer(owner, _newOwner);
    }

    //
    function extendsRegistrationPeriod(uint256 _registrationDuration) public onlyOwner {
        newRegistrationTime = block.timestamp + _registrationDuration; 
        require(block.timestamp > registrationTime, "Registration is active");
        registrationTime = newRegistrationTime;

        ended = false;
    }

    /*
    function changeRegisteredAddress(string memory _registeredUsername, address _newAddress) public {
        require(userNameToAddress[_registeredUsername] != address(0), "Invalid username");
    }
    */

    function endRegistration() public onlyOwner {
        ended = true;
    }


    // "If I wanted to let someone transfer their username to another address, what checks would I need?"
}