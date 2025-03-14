pragma solidity >=0.4.24 < 0.9.0;

contract MyContract{
    // player structure
    struct Player{
        uint id;
        uint256 balance;
    }
    
    // token structure
    struct Token{
        uint id;
    }
    
    uint256 public peopleCount = 0;
    mapping (uint => Player) public Players;
    
    uint256 public tokenCount = 0;
    mapping (uint => Token) public Tokens;

    
    function addPlayer() public {
        incrementCount();
        Players[peopleCount] = Player(peopleCount, 10);
    }
    
    function incrementCount() internal {
        peopleCount += 1;
    }
    
    
    uint public random_id = 0;
    bool double_used_check_flag = true;
    // bool clash_found = true;
    function addToken() public{
        incrementToken();
        allocate_Token_to_player(true);
    }
    
    function incrementToken() internal {
        tokenCount += 1;
    }
    
    function allocate_Token_to_player(bool clash_found) internal {
        while(clash_found){
            clash_found = check_clash(random_id);
            random_id = (uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, tokenCount))) % peopleCount) + 1;
        }
        Tokens[tokenCount] = Token(random_id);
    }
    
    function check_clash (uint randomid) internal view returns (bool) {
        for (uint256 i = 0; i < tokenCount; i++){
            if (Tokens[i].id == randomid){
                return true;
            }
        }
        return false;
    }
    
    function proof_of_work () internal view{
        uint random_number = 500;
        while (random_number > 100){
            random_number = (uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, random_number))) % 1000) + 1;
        }
    }
    
    function token_transfer (uint token_index) public {
        proof_of_work();
        transfer_to_another_person(token_index, true);
    }
    
    function transfer_to_another_person (uint token_index, bool clash_found) internal {
        while(clash_found){
            clash_found = check_clash(random_id);
            random_id = (uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, tokenCount))) % peopleCount) + 1;
        }
        Tokens[token_index].id = random_id;
    }
    
}