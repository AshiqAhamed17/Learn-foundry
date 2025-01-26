// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol"; // OpenZeppelin ERC20
import "../src/CustomERC20.sol";

contract DifferentialTest is Test {
    CustomERC20 public customERC20;
    ERC20 public ozERC20;

    address a;
    address b;

    function setUp() public {
        customERC20 = new CustomERC20();
        ozERC20 = new ERC20("Custom Token", "CTK");

        a = makeAddr("a");
        b = makeAddr("b");

        vm.prank(a);
        customERC20.mint(a, 100 ether);
        deal(address(ozERC20), a, 100 ether);
    }
}