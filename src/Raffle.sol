// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;




/***
 * @title A lottery Contract
 * @author Ali Haghshenas
 * @dev Implement Chainlink VRFv2
 */

import {VRFCoordinatorV2Interface} from "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";


contract Raffle {
    /***Errors */
    error Raffle__NotEnoughEthSent();

    uint256 private constant REQUEST_CONFIRMATIONS = 3;
    uint256 private constant NUM_WORDS = 1;

    uint256 private immutable i_entranceFee;
    // @dev duration of the lottery is seconds
    uint256 private immutable i_interval;
    address private immutable i_vrfCoordinator;
    bytes32 private immutable i_gasLane;
    uint256 private immutable i_subscriptionId;
    uint32 private immutable i_callbackGasLimit;

    address payable[] private s_players;

    uint256 private s_lastTimeStamp;

    /** Events */
    event EnteredRaffle(address indexed player);


    constructor(uint256 entranceFee, uint256 interval , address vrfCoordinator , bytes32 gasLane , uint256 subscriptionId , uint32 callbackGasLimit) {
        i_entranceFee = entranceFee;
        i_interval = interval;
        s_lastTimeStamp = block.timestamp;
        i_vrfCoordinator = vrfCoordinator;
        i_gasLane = gasLane;
        i_subscriptionId = subscriptionId;
        i_callbackGasLimit = callbackGasLimit ;
    }

    function enterRaffle() external payable {
        // require(msg.value >= i_entranceFee , "Not Enough Send!");
        if (msg.value < i_entranceFee) {
            revert Raffle__NotEnoughEthSent();
        }
        s_players.push(payable(msg.sender));
        emit EnteredRaffle(msg.sender);
    }

    function pickWinner() external {
        if ((block.timestamp - s_lastTimeStamp) > i_interval) {
            revert();
        }
   

    }

         
        // Will revert if subscription is not set and funded.
        uint256 requestId = i_vrfCoordinator.requestRandomWords(
            i_gasLane, // gas lane 
            i_subscriptionId,
            REQUEST_CONFIRMATIONS,
            i_callbackGasLimit,
            NUM_WORDS 
        );

    /**Getter Function */

    function getEntranceFee() external view returns (uint256) {
        return i_entranceFee;
    }
}
