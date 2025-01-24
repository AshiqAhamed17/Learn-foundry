// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";

// forge test --match-path test/FFI.t.sol --ffi -vvvv

contract FFI is Test {
    function testFFI1() public {

        string[] memory cmds = new string[](2);
        cmds[0] = "cat";
        cmds[1] = "ffi_test.txt";

        bytes memory res = vm.ffi(cmds);
        console.log(string(res));
    }

    // function testFFI() public {

    //     string[] memory cmds = new string[](2);
    //     cmds[0] = "cat";
    //     cmds[1] = "src/WETH.sol";

    //     bytes memory res = vm.ffi(cmds);
    //     console.log(string(res));
    // }

    function testFetchGoogle() public {
        string[] memory cmds = new string[](2);

        cmds[0] = "curl";
        cmds[1] = "https://www.google.com";

        bytes memory res = vm.ffi(cmds);

        console.log("Google Homepage HTML Content:");
        console.log(string(res));
    }
    
    
}



    // function testParseGoogleTitle() public {
    //     // FFI command to call the Python script
    //     string[] memory cmds = new string[](3);
    //     cmds[0] = "python3";            // Call Python interpreter
    //     cmds[1] = "exp.py";   // Python script file
    //     cmds[2] = "";                  // Add additional args if needed

    //     // Execute FFI
    //     bytes memory res = vm.ffi(cmds);

    //     // Log parsed title
    //     console.log("Title:");
    //     console.log(string(res));
    // }

    

   

    
