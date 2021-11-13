// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.9;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

/**
 * @title Admin
 * @dev allows to manage the users of a application
 */
contract Admin is Ownable{

    //the different states of the users
    enum stateOfAddress{
        Default,
        Blacklist,
        Whitelist
    }

    //mappings
    mapping(address => stateOfAddress) public usersListed;

    //events
    event Whitelisted(address _address);
    event Blacklisted(address _address);

    /**
     * title whitelist
     * @dev put an user in the whitelist 
     * @param _address the @ of the user
     */
    function whitelist(address _address) public onlyOwner{

        require(usersListed[_address] != stateOfAddress.Whitelist,"The address of the user is already whitelisted!");
        usersListed[_address] = stateOfAddress.Whitelist;

        emit Whitelisted(_address);
    }

    /**
     * title blacklist
     * @dev put an user in the blacklist
     * @param _address the @ of the user
     */
    function blacklist(address _address) public onlyOwner{
        require(usersListed[_address] != stateOfAddress.Blacklist,"The address of the user is already blacklisted!");
        usersListed[_address] = stateOfAddress.Blacklist;

        emit Blacklisted(_address);
    }

    /**
     * title isWhitelisted
     * @dev Return the account whitelisted 
     * @return bool
     */
    function isWhitelisted(address _address) public view returns(bool){
        return usersListed[_address] == stateOfAddress.Whitelist;
    }


    /**
     * title isBlacklisted
     * @dev Return the account blacklisted
     * @return bool
     */
    function isBlacklisted(address _address) public view returns(bool){
        return usersListed[_address] == stateOfAddress.Blacklist;
    }
}