// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TestToken is ERC20 {

    constructor() ERC20("ASHQ","AQ") {
        _mint(msg.sender, 1_000_000 * 10**decimals());
    }
}