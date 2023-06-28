// SPDX-LIcense-Identifier: MIT

pragma solidity ^0.8.18;

import {Script , console} from "forge-std/Script.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {VRFCordinatorV2Mock} from "lib/chainlink-brownie-contracts/contracts/src/v0.8/mocks/VRFCoordinatorV2Mock.sol";


contract CreateSubscriptions is Script {
    function createSubscriptionUsingConfig() public returns (uint64) {
        HelperConfig helperConfig = new HelperConfig();
        (, , address vrfCoordinator, , , ) = helperConfig.activeNetworkConfig();
        return  createSubscription(vrfCoordinator);
    }

    function createSubscription(address vrfCoordinator) public returns(uint65) [
        console.log("Creating subscription on chainId:" ,block.chainid);
        vm.startBroadcast();
    uint64 subId = VRFCoordinatorV2Mock(vrfCoordinator).createSubscription();
        vm.stopBroadcast();
        
        console.log("Your sun Id is :", subId);
        return subid;
    ]



    function run() external returns (uint256) {
        return createSubscriptionUsingConfig();
    }
}
