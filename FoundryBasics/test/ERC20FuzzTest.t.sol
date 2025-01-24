// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import { TestToken } from "../src/TestToken.sol";


contract ERC20FuzzTest is Test {
    TestToken public token;

    address public a;
    address public b;

    function setUp() public {
        token = new TestToken();
        a = vm.addr(1);
        b = vm.addr(2);

        token.transfer(a, 1_000 * 10**token.decimals());
        token.transfer(b, 500 * 10**token.decimals());
    }

    function testFuzz_Transfer(uint256 amount) public {
        
        vm.assume(amount > 0);
        vm.assume(amount <= token.balanceOf(a));

        uint256 aBeforeBalance = token.balanceOf(a);
        uint256 bBeforeBalance = token.balanceOf(b);

        vm.prank(a);
        token.transfer(b, amount);

        assertEq(token.balanceOf(a), aBeforeBalance - amount, "Balance Mismatch");
        assertEq(token.balanceOf(b), bBeforeBalance + amount, "Balance Mismatch");

    }

    function testFuzz_ApproveAndTransfer(uint256 amount) public {
        vm.assume(amount > 0);
        vm.assume(amount <= token.balanceOf(a));


        vm.prank(a);
        token.approve(b, amount);
        uint256 initialAllowance = token.allowance(a, b);
        uint256 initialBalanceA = token.balanceOf(a);
        uint256 initialBalanceB = token.balanceOf(b);

        vm.prank(b);
        token.transferFrom(a, b, amount);

        assertEq(token.balanceOf(a), initialBalanceA - amount, "Balance of 'a' mismatch");
        assertEq(token.balanceOf(b), initialBalanceB + amount, "Balance of 'b' mismatch");

        assertEq(token.allowance(a, b), initialAllowance - amount, "Allownace Mismatch");
    }

}