// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;
contract FailSafeVault {
    address public owner;
    bool public paused = false;
    uint public totalDeposited;

    mapping(address => uint) public balances;
    mapping(address => bool) public isBlackListed;

    event Deposits(address indexed sender, uint amount);
    event Withdrawals(address indexed , uint _amount);

    event ReceivedEther(address indexed sender, uint amount);
    event FallbackCalled(address indexed sender, uint amount, bytes data);



    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Access Denied! You're not the owner");
        _;
    }

    modifier whenNotPaused() {
        require(!paused, "Contract is paused, you can't deposit or withdraw at the moment");
        _;
    }

    modifier onlyPositive (uint _amount) {
        require(_amount > 0, "Deposit or withdraw value must be greater than zero");
        _;
    }

    modifier onlyNotBlackListed {
        require(!isBlackListed[msg.sender], "Your address is blacklisted");
        _;
    }

    function deposit() public payable whenNotPaused onlyPositive(msg.value) onlyNotBlackListed {
        balances[msg.sender] += msg.value;
        totalDeposited += msg.value;

        emit Deposits(msg.sender, msg.value);
    }

    function withdraw(uint _amount) public whenNotPaused onlyPositive(_amount) onlyNotBlackListed {
        require(balances[msg.sender] >= _amount, "You don't have enough funds to withdraw");
        payable(msg.sender).transfer(_amount);

        balances[msg.sender] -= _amount;

        emit Withdrawals(msg.sender, _amount);
    }

    function togglePause() public onlyOwner {
        paused = !paused;
    }

    receive() external payable {
        if (msg.value > 1 ether) {
            paused = true;
            emit ReceivedEther(msg.sender, msg.value);
            revert("Contract is paused due to high deposit");
        }
        emit ReceivedEther(msg.sender, msg.value);
    }

    fallback() external payable {
        emit FallbackCalled(msg.sender, msg.value, msg.data);
        revert("Contract does not accept ether from unknown calldata");
    }

    function blacklist(address _user) public onlyOwner {
        require(_user != owner, "Owner can't be blacklisted");
        isBlackListed[_user] = true;
    }

    function unBlacklist(address _user) public onlyOwner {
        isBlackListed[_user] = false;
    }
        
}