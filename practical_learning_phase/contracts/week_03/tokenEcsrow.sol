// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract TokenEscrow {
    address public owner;      // Escrow agent
    uint256 public amount = 1 ether;          
    address public depositor;
    address public beneficiary;
    bool public isApproved;      
    bool public isReleased;      

    event DepositsMade(address indexed depositor, address indexed escrowAgent, uint256 amount);
    event FundsReleased(address indexed escrowAgent, address indexed beneficiary, uint256 amount);
    event Refunded(address indexed escrowAgent, address indexed depositor, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    modifier onlyBeneficiary() {
        require(msg.sender == beneficiary, "Not Beneficiary");
        _;
    }


    function deposit() public payable {
        require(!isApproved, "Already approved");
        require(msg.value == amount, "Incorrect amount");
        depositor = msg.sender;
        isApproved = true;
        emit DepositsMade(depositor, owner, amount);
    }

    function releaseFunds(address _beneficiary) public onlyOwner {
        require(isApproved, "Not approved");
        require(!isReleased, "Funds released");
        payable(_beneficiary).transfer(amount);
        beneficiary = _beneficiary;
        isReleased = true;

        emit FundsReleased(owner, beneficiary, amount);
    }

    function refund() public onlyOwner {
        require(isApproved, "Nothing to refund");
        require(!isReleased, "Funds released");
        payable(depositor).transfer(amount);

        emit Refunded(owner, depositor, amount);
    }

    function getContractBalance() public view returns(uint) {
        return address(this).balance;
    }
}