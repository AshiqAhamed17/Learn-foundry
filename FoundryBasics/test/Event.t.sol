// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { Test } from "forge-std/Test.sol";

import { Event } from "../src/Event.sol";

contract EventTest is Test {
    Event public e;
    event Transfer(address indexed from, address indexed to, uint amount);

    function setUp() public {
        e = new Event();
    }

    function testEmitTransferEvent() public {

        // 1. Tell Foundry which data to check
        // 2. Emit the Expected Event
        // 3. Call the function that should emit the Event
        vm.expectEmit(true, true, false, true); //1
        emit Transfer(address(this), vm.addr(1), 404); //2
        e.transfer(address(this), vm.addr(1), 404); //3

        //Only check for indexed , not checking for data
        vm.expectEmit(true, true, false, false);
        emit Transfer(address(this), vm.addr(1), 200);
        e.transfer(address(this), vm.addr(1), 100);
    }

    function testEmitManyTransferEvent() public {
        address[] memory to = new address[](2);
        to[0] = vm.addr(1);
        to[1] = vm.addr(2);

        uint[] memory amounts = new uint[](2);
        amounts[0] = 100;
        amounts[1] = 700;

        for(uint i=0; i<to.length; i++) {
            // 1. Tell Foundry which data to check
            vm.expectEmit(true, true, false, true);

             // 2. Emit the Expected Event
             emit Transfer(address(this), to[i], amounts[i]);
        }

        // 3. Call the function that should emit the Event
        e.transferMany(address(this), to, amounts);


        


    }
}
