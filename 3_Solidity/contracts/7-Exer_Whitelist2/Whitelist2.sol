// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.9;

contract Whitelist2 {

    mapping (address => bool) whitelist2;

    event Authorized(address _address);

    function authorize(address _address) public {

        whitelist2[_address] = true;

        emit Authorized(_address);
    }
}

