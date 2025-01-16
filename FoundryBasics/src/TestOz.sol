// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/Ownable.sol";

contract TestOz is Ownable {
    constructor(address a) Ownable(a) {
        transferOwnership(a);
    }
}