// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract KtogreTokenMintable {
    address public owner;
    string public name = "KtogreToken";
    string public symbol = "KGT";
    uint8 public decimals = 18;
    uint public totalSupply = 1000;
    uint public maxSupply = 1000000 * (10 ** uint(decimals));

    mapping(address => uint) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;

    event Transfer(address indexed from, address indexed to, uint amount);
    event Approval(address indexed owner, address indexed spender, uint amount);

    constructor() {
        owner = msg.sender;
        balanceOf[owner] = totalSupply;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    function mint(address to, uint amount) public onlyOwner {
        require(totalSupply + amount <= maxSupply, "You can't mint more than the maximum supply");
        totalSupply += amount;
        balanceOf[to] += amount;

        emit Transfer(address(0), to, amount);
    }

    function approve(address spender, uint amount) public onlyOwner returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(owner, spender, amount);
        return true;
    }

    function transferFrom(address from, address to, uint amount) public returns (bool) {
        require(allowance[from][msg.sender] >= amount, "insufficient allowance");
        require(balanceOf[from] >= amount, "Not enough token");
        
        allowance[from][msg.sender] -= amount;
        balanceOf[from] -= amount;
        balanceOf[to] += amount;

        emit Transfer(from, to, amount);
        return true;
    }

    function burn(uint amount) public returns (bool) {
        require(balanceOf[msg.sender] >= amount, "Insufficient balance to burn");

        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
        return true;
        
    }
}