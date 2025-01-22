// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import {Bit} from "../src/Bit.sol";

contract FuzzTest is Test {
    Bit public b;

    function setUp() public {
        b = new Bit();
    }

    function testABC() public pure {
        uint256 x = 7;
        assertEq(x, 7);
    }
}
