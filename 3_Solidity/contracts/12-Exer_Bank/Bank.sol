// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.9;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

/**
 * @title Bank
 * @author Alex
 * @dev Simulation of a bank
 */
contract Bank{

    //We use a library here (SafeMath is deprecated with the recent version of solidity)
    using SafeMath for uint256;

    mapping (address => uint) _balances;

    /**
        name of the function: deposit
        @author Alex
        @notice: allows for the caller to deposit ether (uint)
    */
    function deposit(uint _amount) public payable{
        require(_amount == msg.value, " Send the good amount of Ether!");
        _balances[msg.sender] = _balances[msg.sender].add(_amount);
    }

    /**
        name of the function: transfer
        @author Alex
        @notice Allows to transfer ether from a caller to a recipient
    */
    function transfer(address _recipient, uint _amount) public{
        require(_balances[msg.sender] >= _amount, "Account balance is too low");
        _balances[msg.sender] = _balances[msg.sender].sub(_amount);
        _balances[_recipient] = _balances[msg.sender].add(_amount);
        payable(_recipient).transfer(_amount);
    }

    /**
        name of the function: balanceOf
        @author Alex
        @notice Allows to consult the balance of the caller of the function
    */
    function balanceOf(address _address) public view returns(uint){
        return _balances[_address];

    }
}




