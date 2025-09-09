// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

import {PredictionMath} from "./PredictionMath.sol";

// error StakeEthNotEnough();
error NotOwner();
error RoundNotEnded();
error PotNotEmpty();

contract StakeToPredict {
    using PredictionMath for uint256;

    // Prices, stakes and deadlines
    uint256 public startPrice;
    uint256 public stakeDeadline;
    uint256 public endPrice;
    uint256 public totalUpStakes;
    uint256 public totalDownStakes;
    uint256 public totalWiningSideStakes;
    uint256 public totalPot;
    PredictionMath.Prediction winingSide;

    uint256 constant MINIMUM_USD = 10e18;
    address public owner;

    // users stakes and predictions
    mapping(address => uint256) public stakes;
    mapping(address => PredictionMath.Prediction) public userPredictions;
    mapping(address => uint256) public winnings;

    address[] public players;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert NotOwner();
        }
        _;
    }

    function initializeRound(uint256 durationInSeconds) public onlyOwner {
        require(stakeDeadline == 0, "Round is still active");
        require(startPrice == 0, "Round is still active");
        startPrice = PredictionMath.getLatestPrice();
        stakeDeadline = block.timestamp + durationInSeconds;
    }

    function stake(PredictionMath.Prediction prediction) public payable {
        require(
            msg.value.getConversionRate() >= MINIMUM_USD,
            "Stake ETH not enough"
        );
        require(block.timestamp <= stakeDeadline, "Staking has ended for now");

        stakes[msg.sender] += msg.value;
        userPredictions[msg.sender] = prediction;
        players.push(msg.sender);

        if (prediction == PredictionMath.Prediction.UP) {
            totalUpStakes += msg.value;
        } else {
            totalDownStakes += msg.value;
        }
    }

    function checkWiningSide() public returns (uint256) {
        winingSide = PredictionMath.isPriceHigher(startPrice, endPrice);
        if (winingSide == PredictionMath.Prediction.UP) {
            totalWiningSideStakes = totalUpStakes;
        } else {
            totalWiningSideStakes = totalDownStakes;
        }
        return totalWiningSideStakes;
    }

    function settle() public {
        require(block.timestamp > stakeDeadline, "Staking is still ongoing");
        endPrice = PredictionMath.getLatestPrice();
        checkWiningSide();
        totalPot = totalUpStakes + totalDownStakes;

        for (uint256 i = 0; i < players.length; i++) {
            address player = players[i];
            if (userPredictions[player] == winingSide) {
                uint256 payout = PredictionMath.calculateWinnings(
                    stakes[player],
                    totalWiningSideStakes,
                    totalPot
                );
                winnings[player] = payout;
            }
        }
    }

    function withdrawWinnings() public {
        uint256 amount = winnings[msg.sender];
        require(amount > 0, "No winnings to withdraw");
        winnings[msg.sender] = 0;
        (bool callSuccess, ) = payable(msg.sender).call{value: amount}("");
        require(callSuccess, "call failed");
    }

    function increaseDeadline(
        uint256 additionalTimeInSeconds
    ) public onlyOwner {
        if (block.timestamp >= stakeDeadline) revert RoundNotEnded();
        stakeDeadline += additionalTimeInSeconds;
    }

    function resetRound() public onlyOwner {
        if (block.timestamp <= stakeDeadline) revert RoundNotEnded();
        if (totalPot > 0) revert PotNotEmpty();
        for (uint256 i = 0; i < players.length; i++) {
            address player = players[i];
            delete stakes[player];
            delete userPredictions[player];
            delete winnings[player];
        }
        delete players;
        delete startPrice;
        delete stakeDeadline;
        delete endPrice;
        delete totalUpStakes;
        delete totalDownStakes;
        delete totalWiningSideStakes;
        delete totalPot;
    }
}
