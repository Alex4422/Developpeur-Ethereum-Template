// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.9;

/**
    @notice defines a struct Person
*/
contract Array_avance {

    struct Person{
        string name ;
        uint age ;
    }

    Person person = Person("name", 30);

    function addPerson(string memory _name, uint _age) public {
        Person memory person2;

        person2.name = _name;
        person2.age = _age;
    }


}
