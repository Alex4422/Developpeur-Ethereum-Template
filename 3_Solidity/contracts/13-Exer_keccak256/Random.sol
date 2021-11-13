// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.9;

/**
 * @title Random
 * @author Alex
 * @dev Generates a random number
 */
contract Random{

    uint private nonce = 0 ;

    /**
        name of the function:  random
        @author Alex
        @notice Allows to generate an random number with keccak256 function
    */
    function random() public returns(uint) {
        return uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, nonce++))) % 100;
    }
}