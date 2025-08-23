// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

/// @title WalletRegistryV2
/// @notice Users can register a unique username and link it to their Ethereum address.
/// @dev Extends V1 by adding ownership controls, contract state and event logging.
/// @author ktogre

contract WalletRegistryV2 {

    address public owner;
    bool paused;
    bool ended;

    enum ContractState {Active, Paused, Ended}

    event WalletRegistered(address indexed user, string userName);

    constructor() {
        owner = msg.sender;
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
        require(userNameToAddress[_userName] == address(0), "Username already taken");
        listOfUsers.push(User(_userName, _user));
        userNameToAddress[_userName] = _user;

        emit WalletRegistered(_user, _userName);
    }

    function togglePause() public onlyOwner {
        paused = !paused;
    }

    function checkContractState() public view returns (ContractState) {
        if (ended == true) {
            return ContractState.Ended;
        } else if (paused == true) {
            return ContractState.Paused;
        } else {
            return ContractState.Active;
        }
    }

    function endRegistration() public onlyOwner {
        ended = true;
    }
}