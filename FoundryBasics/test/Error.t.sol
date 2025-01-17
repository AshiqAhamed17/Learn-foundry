// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";

import {Error} from "../src/Error.sol";

contract ErrorTest is Test {
    Error public e;

    function setUp() public {
        e = new Error();
    }

    function testFail() public view {
        e.throwError();
    }

    function testRevert() public {
        vm.expectRevert();
        e.throwError();
    }

    function testRequireMessage() public {
        vm.expectRevert(bytes("Not Authorized"));
        e.throwError();
    }

    function testCustomError() public {
        vm.expectRevert(Error.NotAuthorized.selector);
        e.throwCustomError();
    }
}
