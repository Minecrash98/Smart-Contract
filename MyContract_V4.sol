pragma solidity >=0.4.24 < 0.9.0;

contract MyContract_V4{
    
    uint256 peopleCount = 0;
    
    mapping (uint => Person) public people;
    
    struct Person{
        uint _id;
        string _firstName;
        string _lastName;
    }
    
    function addPerson (string memory _firstName, string memory _lastName) public{
        peopleCount += 1;
        people[peopleCount] = Person(peopleCount, _firstName, _lastName);
    }
}