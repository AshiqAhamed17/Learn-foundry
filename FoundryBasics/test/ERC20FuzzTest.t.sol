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
        
    }



}