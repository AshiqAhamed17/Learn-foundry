// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Wallet {
    address payable public owner;

    constructor() payable {
        owner = payable(msg.sender);
    }

    receive() external payable {}

    function withdraw(uint256 _amount) external {
        require(owner == msg.sender, "Not the owner");
        payable(msg.sender).transfer(_amount);
    }

    function setOwner(address _owner) external {
        require(msg.sender == owner, "Not the owner");
        owner = payable(_owner);
    }
}
