# ContractBanking

This Solidity contract demonstrates basic banking functionality with deposit, withdrawal, and daily withdrawal limit management. It ensures that users can deposit funds, withdraw with specific constraints, and reset their daily withdrawal count.
# Description

The ContractBanking is designed to simulate basic banking operations with proper checks for deposit, withdrawal, and daily withdrawal limits. It includes:

    Deposit Funds: The depositFunds function allows users to deposit funds, ensuring the total balance does not exceed the allowed maximum limit.
    Withdraw Funds: The withdrawFunds function enables users to withdraw funds, with constraints on available balance, daily withdrawal cap, and withdrawal amount increments.
    Reset Daily Withdrawals: The resetDailyWithdrawals function allows users to reset their daily withdrawal limit tracking.

Key Features:

    Deposit Validation: Ensures the deposited amount is positive and the total balance doesn't exceed the maximum allowed balance.
    Withdrawal Constraints: Validates withdrawal amounts, ensuring they are in multiples of 100 and within the daily withdrawal limit.
    Event Emission: Emits an event when a withdrawal is successfully made for tracking purposes.

## Getting Started

To use this contract, you will need a Solidity environment where you can deploy and interact with smart contracts. The most common tool is Remix, an online IDE for Solidity.
Prerequisites:

    Solidity 0.8.28 or a compatible version
    Access to Remix IDE (https://remix.ethereum.org)

Executing the Program

    Open Remix IDE.
    Create a new file: Click the "+" icon in the left sidebar and name it ContractBanking.sol.
    Copy and paste the following contract code into the file:

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ContractBanking {
    uint public currentBalance;
    uint public maxAllowedBalance = 20000;
    uint public dailyWithdrawalCap = 2000;
    
    event WithdrawalMade(address indexed user, uint amount);

    mapping(address => uint) public withdrawalsToday;

    // Deposit funds into the contract, ensuring the balance doesn't exceed max allowed
    function depositFunds(uint amount) public {
        require(amount > 0, "Deposit amount must be greater than zero.");
        assert(currentBalance + amount <= maxAllowedBalance); // Ensure total balance doesn't exceed max allowed
        currentBalance += amount;
    }

    // Withdraw funds with checks for daily limit and withdrawal multiples
    function withdrawFunds(uint amount) public {
        require(amount <= currentBalance, "Insufficient funds.");
        require(amount + withdrawalsToday[msg.sender] <= dailyWithdrawalCap, "Exceeded daily withdrawal limit.");
        
        if (amount % 100 != 0) {
            revert("Withdrawal must be in multiples of 100.");
        }

        currentBalance -= amount;
        withdrawalsToday[msg.sender] += amount;

        emit WithdrawalMade(msg.sender, amount); // Emit withdrawal event
    }

    // Reset the daily withdrawal count for the user
    function resetDailyWithdrawals() public {
        withdrawalsToday[msg.sender] = 0;
    }
}

Compiling and Deploying the Contract

    Compile the Contract:
        Click on the Solidity Compiler tab in Remix.
        Set the compiler version to 0.8.28 (or a compatible version).
        Click "Compile ContractBanking.sol."

    Deploy the Contract:
        Go to the Deploy & Run Transactions tab.
        Select ContractBanking from the dropdown menu.
        Click "Deploy."

    Once the contract is deployed, it will appear under Deployed Contracts on the Remix interface.

Interacting with the Contract

After deployment, you can interact with the contract using the following functions:

    depositFunds:
        To deposit funds, enter a positive value in the input box and click "depositFunds."
        The contract will check that the deposit is positive and ensures the balance doesn't exceed the max allowed.

    withdrawFunds:
        To withdraw funds, enter the withdrawal amount and click "withdrawFunds."
        The contract checks for sufficient funds, ensures the withdrawal amount doesn't exceed the daily limit, and confirms the amount is a multiple of 100.

    resetDailyWithdrawals:
        To reset the daily withdrawal count, click "resetDailyWithdrawals."

Authors

Metacrafter Chris_Narumi.
License

This project is licensed under the MIT License. See the LICENSE.md file for details.
