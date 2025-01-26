// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol"; // OpenZeppelin ERC20
import "../src/CustomERC20.sol";

// Simple implementation of ERC20
contract SimpleERC20 is ERC20 {
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {}

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}

contract DifferentialTest is Test {
    CustomERC20 public customERC20;
    SimpleERC20 public ozERC20;

    address a;
    address b;

    function setUp() public {
        customERC20 = new CustomERC20();
        ozERC20 = new SimpleERC20("Custom Token", "CTK");

        a = makeAddr("a");
        b = makeAddr("b");

        vm.prank(a);
        customERC20.mint(a, 100 ether);
        deal(address(ozERC20), a, 100 ether);
    }

    function testDifferential_tokenName() public view {
        assertEq(customERC20.name(), ozERC20.name(), "Token name Mismatch");
    }

    function testDifferential_transfer() public {
        uint256 amount = 10 ether;

        vm.startPrank(a);
        customERC20.transfer(b, amount);
        ozERC20.transfer(b, amount);
        vm.stopPrank();

        assertEq(
            customERC20.balanceOf(a),
            ozERC20.balanceOf(a),
            "B Balance Mismatch"
        );
        assertEq(
            customERC20.balanceOf(b),
            ozERC20.balanceOf(b),
            "A Balance Mismatch"
        );
    }

    function testDifferential_approveAndTransferFrom() public {
        uint256 approveAmount = 15 ether;
        uint256 transferAmount = 10 ether;

        vm.startPrank(a);
        customERC20.approve(b, approveAmount);
        ozERC20.approve(b, approveAmount);
        vm.stopPrank();

        vm.startPrank(b);
        customERC20.transferFrom(a, b, transferAmount);
        ozERC20.transferFrom(a, b, transferAmount);
        vm.stopPrank();

        assertEq(
            customERC20.allowance(a, b),
            ozERC20.allowance(a, b),
            "Allowance Mismatch"
        );
        assertEq(
            customERC20.balanceOf(a),
            ozERC20.balanceOf(a),
            "Account A Balance mismatch"
        );
        assertEq(
            customERC20.balanceOf(b),
            ozERC20.balanceOf(b),
            "Account B Balance mismatch"
        );
    }
}
