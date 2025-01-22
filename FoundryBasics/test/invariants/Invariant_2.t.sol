// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import {WETH} from "../../src/WETH.sol";

// Topics
// - handler based testing - test functions under specific conditions
// - target contract
// - target selector

import {CommonBase} from "forge-std/Base.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {StdUtils} from "forge-std/StdUtils.sol";

contract Handler is CommonBase, StdUtils, StdCheats {
    WETH public weth;
    uint256 public wethBalance;
    uint256 public numCalls;

    constructor(WETH _weth) {
        weth = _weth;
    }

    function sendToFallback(uint _amount) public {
        _amount = bound(_amount, 0, address(this).balance);

        wethBalance += _amount;
        numCalls++;
        (bool success,) = address(weth).call{value: _amount}("");
        require(success, "Failed to send to fallback");
    }

    function deposit(uint _amount) public {
        _amount = bound(_amount, 0, address(this).balance);

        wethBalance += _amount;
        numCalls++;

        weth.deposit{value: _amount}();
    }

    function withdraw(uint _amount) public {

        _amount = bound(_amount, 0, weth.balanceOf(address(this)));
        wethBalance -= _amount;
        numCalls++;
        weth.withdraw(_amount);
    }

    //Function to just fail the test 
    function fail() public pure {
        revert("Failed");
    }
}