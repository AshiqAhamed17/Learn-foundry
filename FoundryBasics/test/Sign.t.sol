// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test } from "forge-std/Test.sol";
import "forge-std/console.sol";

contract SignTest is Test {
    // private key = 123
    // public key = vm.addr(private key)
    // message = "secret message"
    // message hash = keccak256(message)
    // vm.sign(private key, message hash)

    function testSignatureOne() public pure {
        uint256 privateKey = 69;
        address pubKey = vm.addr(privateKey);

        bytes32 messageHash = keccak256("This is a Secret!");

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(privateKey, messageHash);

        address signer = ecrecover(messageHash, v, r, s);

        assertEq(signer, pubKey);

        bytes32 newHash = keccak256("Wrong!!");
        signer = ecrecover(newHash, v, r, s);
        assertTrue(signer != pubKey);
    }

    function testSignatureTwo() public {
        (address ash, uint256 ashPk) = makeAddrAndKey("Ash");
        bytes32 messageHash = keccak256("Secret!!");
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(ashPk, messageHash);
        address signer = ecrecover(messageHash, v, r, s);
        assertEq(signer, ash, "Not the signer");
    }
}