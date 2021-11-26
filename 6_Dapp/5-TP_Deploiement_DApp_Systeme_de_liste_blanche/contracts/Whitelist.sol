// SPDX-License-Identifier: MIT
pragma solidity 0.6.11;

//La DApp est déployé à cette @: https://powerful-bastion-79938.herokuapp.com/
contract Whitelist {
    mapping(address=> bool) public _whitelist;
    address[] public addresses;
    event Whitelisted(address _address); 

    function whitelist(address _address) public {
        require(!_whitelist[_address], "This address is already whitelisted !");
        _whitelist[_address] = true;
        addresses.push(_address);
        emit Whitelisted(_address);
    }

    function getAddresses() public view returns(address[] memory){
        return addresses;
    }

}
