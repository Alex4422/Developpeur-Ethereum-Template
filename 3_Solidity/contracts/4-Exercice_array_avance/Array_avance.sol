// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.9;

/**
    @notice defines a struct Person
*/
contract WhitelistStruct {

    struct Person{
        string name;
        uint age;
    }

    Person[] public people;

    function add(string memory _name, uint _age) public {
        Person memory person1;

        person1.name = _name;
        person1.age = _age;

        people.push(person1);
    }

    function remove() public {
        people.pop();
    }
}
