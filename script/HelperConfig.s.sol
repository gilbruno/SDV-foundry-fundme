// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import { Script } from "forge-std/Script.sol";

import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator.sol";

contract HelperConfig is Script {

    //If we are on a local anvil blockchain, we deploy mocks
    // otherwise, grab the existing address from the live network

    uint256 private constant SEPOLIA_CHAIN_ID = 111555111;

    NetworkConfig public activeNetworkConfig;

    struct NetworkConfig {
        address priceFeed;
    }

    constructor() {
        if (block.chainid == SEPOLIA_CHAIN_ID ) {
            activeNetworkConfig = getSepoliaEthConfig();
        }
        else {
            activeNetworkConfig = getAnvilEthConfig();
        }
    }

    function getSepoliaEthConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory sepoliaConfig = NetworkConfig({
            priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        });
        return sepoliaConfig;
    }

    /**
     * No price feed exists in the local blockchain so we have to mock it
     */
    function getAnvilEthConfig() public returns (NetworkConfig memory) {

        vm.startBroadcast();
        MockV3Aggregator mockPriceFeed = new MockV3Aggregator(8, 2000e18);

        vm.stopBroadcast();


        NetworkConfig memory anvilConfig = NetworkConfig({
            priceFeed: address(mockPriceFeed)
        });
        return anvilConfig;
    }
}