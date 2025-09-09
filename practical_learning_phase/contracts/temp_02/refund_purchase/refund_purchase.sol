// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract RefundablePurchase {
    address public seller;
    address public buyer;
    uint public price;
    bool public purchased;

    event Purchases(address indexed buyer, uint amount);
    event Refunds(address indexed buyer, uint amount);
    event Withdraws(address indexed seller, uint amount);

    constructor(uint _price) {
        seller = msg.sender;
        price = _price;
    }

    modifier onlyBuyer() {
        require(msg.sender == buyer, "Not buyer");
        _;
    }

    modifier onlySeller() {
        require(msg.sender == seller, "Not seller");
        _;
    }

    function purchaseProduct() external payable {
        require(!purchased, "Already purchased");
        require(msg.value == price, "Incorrect amount");
        buyer = msg.sender;
        purchased = true;
        emit Purchases(msg.sender, msg.value);
    }

    receive() external payable {
        revert("Use purchaseProduct function to send Ether");
    }

    fallback() external payable {
        revert("Invalid function call");
    }

    function refund() public onlySeller {
        require(purchased, "Nothing to refund");
        payable(buyer).transfer(price);
        purchased = false;
        buyer = address(0);

        emit Refunds(buyer, price);
    }

    function withdraw() public onlySeller {
        require(purchased, "No purchase");
        uint amount = address(this).balance;
        payable(seller).transfer(amount);
        purchased = false;

        emit Withdraws(seller, amount);
    }
}