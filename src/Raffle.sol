// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

/***
 * @title A lottery Contract
 * @author Ali Haghshenas
 * @dev Implement Chainlink VRFv2
 */

contract Raffle {
    uint256 private immutable i_entranceFee;

    constructor(uint256 entranceFee) {
        i_entranceFee = entranceFee;
    }

    function enterRaffle() public payable {}

    function pickWinner() public {}


        /**Getter Function */

        function getEntranceFee() external view returns(uint256) {

            return i_entranceFee;

        }



}
