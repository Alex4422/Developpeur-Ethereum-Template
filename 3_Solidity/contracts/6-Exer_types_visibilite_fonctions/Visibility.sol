// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.9;

contract Visibility {

    //creation of a variable string
    string public myString = "Hello World";

    function hello() public view returns (string memory) {
        return myString;
    }

}
