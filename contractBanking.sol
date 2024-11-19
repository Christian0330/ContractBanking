// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ContractBanking {
    uint public currentBalance;
    uint public maxAllowedBalance = 20000;
    uint public dailyWithdrawalCap = 2000;
    
    event WithdrawalMade(address indexed user, uint amount);

    mapping(address => uint) public withdrawalsToday;

 
    function depositFunds(uint amount) public {
        require(amount > 0, "Deposit amount must be greater than zero.");
        assert(currentBalance + amount <= maxAllowedBalance); 
        currentBalance += amount;
    }

    function withdrawFunds(uint amount) public {
        require(amount <= currentBalance, "Insufficient funds.");
        require(amount + withdrawalsToday[msg.sender] <= dailyWithdrawalCap, "Exceeded daily withdrawal limit.");
        
        if (amount % 100 != 0) {
            revert("Withdrawal must be in multiples of 100.");
        }

        currentBalance -= amount;
        withdrawalsToday[msg.sender] += amount;

        emit WithdrawalMade(msg.sender, amount);
    }

    function resetDailyWithdrawals() public {
        withdrawalsToday[msg.sender] = 0;
    }
}
