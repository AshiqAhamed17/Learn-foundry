// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {CommonBase} from "forge-std/Base.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {StdUtils} from "forge-std/StdUtils.sol";

import {WETH} from "../../src/WETH.sol";

contract Handler1 is CommonBase, StdUtils, StdCheats {
    WETH public weth;

    constructor(WETH _weth) {
        weth = _weth;
        deal(address(this), 10 ether);
    }

    receive() external payable {}

    function deposit(uint _amount) public {
        _amount = bound(_amount, 0.01 ether, address(this).balance);
        weth.deposit{value: _amount}();
    }

    function withdraw(uint _amount) public {
        uint bal = weth.balanceOf(address(this));
        _amount = bound(_amount, 0.01 ether, bal);

        if (bal > 0) {
            weth.withdraw(_amount);
        }
    }

    function transfer(address _rec, uint _amount) public {
        uint bal = weth.balanceOf(address(this));
        _amount = bound(_amount, 0.01 ether, bal);

        if (bal > 0 && _rec != address(0)) {
            weth.transfer(_rec, _amount);
        }
    }

    function ethBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function wethBalance() public view returns (uint256) {
        return weth.balanceOf(address(this));
    }


}
