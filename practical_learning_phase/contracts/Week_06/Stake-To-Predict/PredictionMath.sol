// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

// import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import "./AggregatorV3Interface.sol";


//  I don't have chainlink installed locally, 
//  that's why i used the alternative


library PredictionMath {
    enum Prediction {UP, DOWN}

    function getLatestPrice() internal view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 answer,,,) = priceFeed.latestRoundData();
        return uint256(answer * 1e18); // Type casting: converting the 8 decimals place of answer(price in USD) 
        // to the 18 decimal places of msg.value
    }

    function getConversionRate(uint256 ethAmout) internal view returns (uint256) {
        uint256 ethPrice = getLatestPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmout) / 1e18;
        return  ethAmountInUsd;

    }

    function isPriceHigher(uint256 startPrice, uint256 endPrice) internal pure returns (Prediction) {
        if (endPrice > startPrice) {
            return Prediction.UP;
        } else {
            return Prediction.DOWN;
        }
    }

    function calculateWinnings(uint256 userStake, uint256 totalWinningSideStakes, uint256 totalPot) internal pure returns (uint256) {
        if (totalWinningSideStakes == 0) {
            return 0;
        }
        uint256 payout = (userStake * totalPot) / totalWinningSideStakes;
        return payout;
    }

}