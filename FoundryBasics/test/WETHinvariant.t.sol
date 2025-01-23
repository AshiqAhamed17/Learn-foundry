// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import {WETH} from "../src/WETH.sol"; // If not working create WETH9.sol
import {Handler1} from "./invariants/Handler1.sol";

contract WETHinvariant is Test {
    WETH public weth;
    Handler1 public handler;

    function setUp() public {
        weth = new WETH();
        handler = new Handler1(weth);

        targetContract(address(handler));
    }

    function invariant_weth_supply_isalways_zero() public view{
        assertEq(0, weth.totalSupply());
    }
}