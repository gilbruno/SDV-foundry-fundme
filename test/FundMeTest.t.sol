// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import { Test, console } from "forge-std/Test.sol";
// import { FundMe } from "../src/1/FundMe.sol";
import { FundMe } from "../src/2/FundMe.sol";
import { DeployFundMe } from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test {

    uint256 number = 1;
    FundMe fundMe;

    /** Lesson #1 */
    // function setUp() external {
    //     fundMe = new FundMe();
    // }

    /** Lesson #2-a */
    // function setUp() external {
    //     fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    // }

    /** Lesson #2-b */
    function setUp() external {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
    }

    /****************** 1 ******************************/
    function test1MinimumDollarIsFive() public {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function test1OwnerIsMsgSender() public {
        assertEq(fundMe.i_owner(), msg.sender/*address(this)*/);
    }

    function test1PriceFeedVErsionIsAccurate() public {
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
    }

    /****************** 2 ******************************/
   function test2PriceFeedVErsionIsAccurate() public {
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
    }

}