// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

/// @title WalletRegistryV1
/// @notice Users can register a unique username and link it to their Ethereum address.
/// @dev uses a mapping to enforce uniqueness. Future versions will add updates, removals, and extra metadata.
/// @author ktogre

contract WalletRegistryV1 {

    struct User {
        string userName;
        address user; 
    }

    User[] public listOfUsers;

    mapping(string => address) userNameToAddress;

    // allows users to register their wallet address to a unique username
    function registerWalletAddress(string memory _userName, address _user) public {
        require(userNameToAddress[_userName] == address(0), "Username already taken");
        listOfUsers.push(User(_userName, _user));
        userNameToAddress[_userName] = _user;
    }
}