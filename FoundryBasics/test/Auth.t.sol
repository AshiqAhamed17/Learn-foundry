// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {stdError} from "forge-std/StdError.sol";

import { Wallet } from "../src/Wallet.sol";

contract AuthTest is Test {
    Wallet public w;

    function setUp() public {
        w = new Wallet();
    }

    function testSetOwner() public {
        address ad = vm.addr(1); 
        w.setOwner(ad);
        assertEq(w.owner(), ad);
    }

    function testFailNotOwner() public {
        address ad = vm.addr(1);
        vm.prank(ad);
        w.setOwner(vm.addr(2));
    }

    function testFailSetOwnerAgain() public {
        address ad = vm.addr(1);
        w.setOwner(ad);

        vm.startPrank(ad);
        w.setOwner(ad);
        w.setOwner(ad);

        w.setOwner(vm.addr(2));
        vm.stopPrank();

        w.setOwner(ad);
    }
}