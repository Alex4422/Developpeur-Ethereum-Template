// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.9;

/**
    @notice defines a struct Person
*/
contract WhitelistStruct {

    struct Person{
        string name ;
        uint age ;
    }

    Person person = Person("name", 30);

    function addPerson(string _name, uint _age) public {
        Person memory person;

        this.name = _name;
        this.age = _age;
    }


}
