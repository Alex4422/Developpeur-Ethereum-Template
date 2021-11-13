// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.9;

contract Choice {

    mapping (address => uint) public choices;

    function add(uint _myuint) public {

        choices[msg.sender] = _myuint;
    }
}
