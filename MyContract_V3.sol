pragma solidity >=0.4.24 < 0.9.0;

contract MyContract_V3{
    struct Person{
        string _firstName;
        string _lastName;
    }
    
    Person [] people;
    uint256 public peopleCount;
    // uint256 index = 0;
    
    function addPerson (string memory _firstName, string memory _lastName) public {
        people.push(Person(_firstName,_lastName));
        peopleCount += 1;
    }
    
    // function setIndex (uint256 _index) public {
    //     index = _index;
    // }
    
    function getLastName(uint256 index) public view returns (string){
        // string to_return = people[index];
        return people[index]._lastName;
    } 
    
    function getFullName(uint256 index) public view returns (string, string){
        return (people[index]._firstName, people[index]._lastName);
    }
    
}