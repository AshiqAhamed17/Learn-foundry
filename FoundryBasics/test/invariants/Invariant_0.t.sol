// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
// Topics
// - Invariant
// - Difference between fuzz and invariant
// - Failing invariant
// - Passing invariant
// - Stats - runs, calls, reverts

contract InvariantIntro {
    bool public flag;

    function flag_1() external {}
    function flag_2() external {}
    function flag_3() external {}
    function flag_4() external {}

    function flag_5() external {
        flag = true;
    }
}

contract InvariantIntroTest is Test {
    InvariantIntro private target;

    function setUp() public {
        target = new InvariantIntro();
    }

    function invariant_flag_is_always_false() public view {
        assertEq(target.flag(), false, "Flag is true somewhere");
    }
}
