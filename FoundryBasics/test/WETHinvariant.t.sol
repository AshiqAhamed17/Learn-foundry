// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import {WETH} from "../src/WETH.sol";
import {Handler} from "./invariants/Handler.sol";

contract WETHinvariant is Test {
    WETH public weth;
    Handler public handler;

    function setUp() public {
        weth = new WETH();
        handler = new Handler(weth);

        targetContract(address(handler));
    }

    function invariant_weth_supply_isalways_zero() public view{
        assertEq(0, weth.totalSupply());
    }
}