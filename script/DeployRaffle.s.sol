// SPDX-LIcense-Identifier: MIT

pragma solidity ^0.8.18 ;

import {Script} from "forge-std/Script.sol";
import {Raffle} from "../src/Raffle.sol";
import {CreateSubscription} from "./Interactions.s.sol";
import {HelperConfig} from "./HelperConfig.s.sol";


contract DeployRaffle is Script (){


function run() external returns(Raffle) {
 HelperConfig helperConfig = new HelperConfig();
 (
    uint256 entranceFee,
        uint256 interval,
        address vrfCoordinator,
        bytes32 gasLane,
        uint64 subscriptionId,
        uint32 callbackGasLimit
 ) = helperConfig.activeNetworkConfig();

 if(subscriptionId ==0) {
    // we are going to need to create a subscripton
    CreateSubscription createSubscription = new CreateSubscription();
    subscriptionId = createSubscription.createSubscription(vrfCoordinator);
 }

vm.startBroadcast();
Raffle raffle = new Raffle(
entranceFee,
interval,
vrfCoordinator,
gasLane,
subscriptionId,
callbackGasLimit
);
vm.stopBroadcast();

return raffle ;

}


}