// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Hello} from "../src/Hello.sol";

contract HelloTest is Test {
    Hello public h;

    function setUp() public {
        h = new Hello();
    }

    function testHello() public view {
        assertEq(h.message(), "Hello, World!");
    }

    function testSetMessage() public {
        h.setMessage();
        assertEq(h.message(), "Hello Foundry!");
    }
}
