// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract TokenAllowance {
    string public name = "KtogreToken";
    string public symbol = "KGT";
    uint8 public decimals = 18;
    uint public totalSupply = 1000000 * (10 ** uint(decimals));

    mapping(address => uint) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;

    event Transfer(address indexed from, address indexed to, uint amount);
    event Approval(address indexed owner, address indexed spender, uint amount);

    constructor() {
        balanceOf[msg.sender] = totalSupply;
    }

    function transfer(address to, uint amount) public returns (bool) {
        require(balanceOf[msg.sender] >= amount, "Not enough tokens to transfer");

        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;

        emit Transfer(msg.sender, to, amount);
        return true;
    }

    function approve(address spender, uint amount) public returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address from, address to, uint amount) public returns (bool) {
        require(allowance[from][msg.sender] >= amount, "Minimum accepted allowance exceeded");
        require(balanceOf[from] >= amount, "Not enough tokens");
        
        allowance[from][msg.sender] -= amount;
        balanceOf[from] -= amount;
        balanceOf[to] += amount;

        emit Transfer(from, to, amount);
        return true;
    }

    function totalSupply() public view returns (uint) {
        return totalSupply;
    }
}