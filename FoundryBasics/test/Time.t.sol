// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Auction} from "../src/Time.sol";

contract TimeTest is Test {
    Auction public auction;
    uint256 private startAt;

    // vm.warp - set block.timestamp to future timestamp
    // vm.roll - set block.number
    // skip - increment current timestamp
    // rewind - decrement current timestamp

    function setUp() public {
        auction = new Auction();
        startAt = block.timestamp;
    }

    function testBidFailsBeforeStartTime() public {
        vm.expectRevert(bytes("Cannot bid"));
        auction.bid();
    }

    function testBid() public {
        vm.warp(startAt + 1 days);
        auction.bid();
    }

    function testBidFailsAfterFinishTime() public {
        vm.expectRevert(bytes("Cannot bid"));
        vm.warp(startAt + 2 days);
        auction.bid();
    }

    function testTimeStamp() public {
        uint t = block.timestamp;
        // set block.timestamp to t + 100
        skip(100);
        assertEq(block.timestamp, t + 100);

        // set block.timestamp to t + 100 - 10;
        rewind(10);
        assertEq(block.timestamp,  t + 90);
    }
    
    function testBlockNumber() public {
        // set block number to 17
        vm.roll(17);
        assertEq(block.number, 17);
    }

}
