// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import "../src/ERC20.sol";

contract Token is ERC20 {
    constructor(string memory _name, string memory _symbol, uint8 _decimals)
        ERC20(_name, _symbol, _decimals)
    {}

    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }
}

contract TokenScript is Script {
    
    function run() public {
        uint privateKey = vm.envUint("DEV_PRIVATE_KEY");
        address account = vm.addr(privateKey);
        console.log("ACCOUNT", account);

        vm.startBroadcast(privateKey);
        //Deploy Token
        Token token = new Token("Test Foundry", "Test", 18);
        //mint

        uint256 mintAmount = 500 * 10 ** 18;
        console.log("Minting", mintAmount, "tokens to", account);
        token.mint(account, mintAmount);

        uint256 totalSupply = token.totalSupply();
        uint256 accountBalance = token.balanceOf(account);
        console.log("Total Supply after Mint:", totalSupply);
        console.log("Account Balance after Mint:", accountBalance);
        
        vm.stopBroadcast();
    }
}

