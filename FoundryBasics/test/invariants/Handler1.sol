// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {CommonBase} from "forge-std/Base.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {StdUtils} from "forge-std/StdUtils.sol";

import {WETH} from "../../src/WETH.sol";


contract Handler1 is CommonBase, StdUtils, StdCheats {
    WETH public weth;

    constructor (WETH _weth) {
        weth = _weth;
        deal(address(this), 10 ether);
    }

    function deposit(uint _amount) public {
        weth.deposit{value: _amount}();
    }

}