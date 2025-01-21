// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ForkTest is Test {
    IERC20 public dai;

    function setUp() public {
        dai = IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F);
    }

    function testDeposit() public {
        address ash = address(123);

        uint256 balBefore = dai.balanceOf(ash);
        console.log("Before Balance :", balBefore);

        // token, account, amount, adjust total supply
        deal(address(dai), ash, 1e6);

        uint256 balAfter = dai.balanceOf(ash);
        console.log("After Balance :", balAfter);

        assertEq(dai.balanceOf(ash), balBefore + balAfter);
    }
}
