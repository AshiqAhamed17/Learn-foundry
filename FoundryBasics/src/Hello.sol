// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Hello {
    string public message = "Hello, World!";

    function setMessage() public {
        message = "Hello Foundry!";
    }
}