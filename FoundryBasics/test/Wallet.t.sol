// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import "forge-std/console.sol";
import {Wallet} from "../src/Wallet.sol";

// Examples of deal and hoax
// deal(address, uint) - Set balance of address
// hoax(address, uint) - deal + prank, Sets up a prank and set balance

contract WalletTest is Test {
    Wallet public w;

    function setUp() public {
        w = new Wallet();
    }

    receive() external payable {}

    function testLogBalance() public view {
        console.log("ETH Balance: ", address(this).balance / 1e18);
    }

    function _send(uint256 _amount) private {
        (bool ok,) = address(w).call{value: _amount}("");
        require(ok, "Faile to send ETH");
    }

    function testSendEth() public {
        uint256 bal = address(w).balance;
        address ad = vm.addr(1);

        //deal
        deal(ad, 100);
        assertEq(ad.balance, 100);

        deal(ad, 10);
        // Note: the balance will not be 110. it will the newly added deal i.e => 10
        assertEq(ad.balance, 10);

        // deal + prank
        deal(ad, 123);
        vm.prank(ad);
        _send(123);

        //hoax => deal + prank
        hoax(ad, 456);
        _send(456);

        assertEq(address(w).balance, bal + 123 + 456);
    }

    function testFailWithdrawNotOwner() public {
        vm.prank(vm.addr(1));
        w.withdraw(100);
    }

    function testWithdraw() public {
        uint256 bal = address(w).balance;
        w.withdraw(100);
        assertEq(address(w).balance, bal - 100);
    }

    function testWithdrawNotOwner() public {
        // Test fail and check error message
        vm.prank(vm.addr(1));
        vm.expectRevert(bytes("Not the owner"));
        w.withdraw(100);
    }
}
