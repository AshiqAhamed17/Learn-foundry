// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {stdError} from "forge-std/StdError.sol";

import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public c;

    function setUp() public {
        c = new Counter();
    }

    function testInc() public {
        c.inc();
        assertEq(c.get(), 1);
    }

    function testFailDec() public {
        c.dec();
    }

    function testDecUnderflow() public {
        vm.expectRevert(stdError.arithmeticError);
        c.dec();
    }

    function testDec() public {
        c.inc();
        c.inc();
        c.dec();
        assertEq(c.get(), 1);
    }
}
