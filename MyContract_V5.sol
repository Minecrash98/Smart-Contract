pragma solidity >=0.4.24 < 0.9.0;

contract MyContract_V5{
    
    uint256 public peopleCount = 0;
    mapping (uint => Person) public people;
    uint256 startTime;
    
    address owner;
    
    
    struct Person{
        uint _id;
        string _firstName;
        string _lastName;
    }
    
    constructor() {
        owner = msg.sender;
        startTime = 1629773580;
    }
    
    function addPerson(string memory _firstName, string memory _lastName) public onlyOwner onlyWhileOpen{
        incrementCount();
        people[peopleCount] = Person(peopleCount, _firstName, _lastName);
    }
    
    function incrementCount() internal {
        peopleCount += 1;
    }
    
    modifier onlyWhileOpen(){
        require(block.timestamp >= startTime);
        _;
    }
    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }
}