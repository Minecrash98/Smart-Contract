// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.4.24 < 0.9.0;

contract MyContract{
    
    //////////////////// Structure Declaration /////////////////////////
    
    // player structure
    struct Player{
        // address id; // uncomment only for deployment
        uint id; // Comment this during deployment
        uint256 balance;
        bool active;
    }
    
    // token structure
    struct Token{
        uint id;
        bool active;
    }
    
    //////////////////// Structure Declaration End /////////////////////////
    
    //////////////////// Variable Declaration /////////////////////////
    // Current 'money' in the game
    uint256 public current_pool=0;
    
    // Random id in which we can check who is the last person the token allocated to
    uint public random_id = 0;
    
    uint256 public peopleCount = 0;
    mapping (uint => Player) public Players;
    
    uint256 public tokenCount = 0;
    mapping (uint => Token) public Tokens;

    //////////////////// Variable Declaration End /////////////////////////
    
    //////////////////// Critical Functions /////////////////////////
    
    // uncomment only for deployment
    // event Registration(string);
    // function addPlayer(address player_address) private {
    //     incrementCount();
    //     Players[peopleCount] = Player(player_address, 1000);
    // }
    
    function addPlayer() public {
        incrementCount();
        Players[peopleCount] = Player(peopleCount, 10, true);
    }
    
    
    function addToken() public{
        incrementToken();
        allocate_Token_to_player(tokenCount, true);
    }
    
    
    function token_transfer (uint token_index) public {
        uint mul_factor;
        // mul_factor = proof_of_work();
        mul_factor = 10; // to prevent browser from entering a script take too long to load state
        transfer_to_another_person(token_index, mul_factor, true);
        
        // check if the game is over --> meaning no more active tokens
        if (is_it_game_over() == true){
            // trigger payout event
        }
    }
    
    function activate_token (uint token_index) public {
        allocate_Token_to_player(token_index, true);
        Tokens[token_index].active = true;
    }
    
    //////////////////// Critical Functions End /////////////////////////
    
    //////////////////// helper Functions /////////////////////////

    
    function incrementCount() internal {
        peopleCount += 1;
    }
    
    
    function incrementToken() internal {
        tokenCount += 1;
    }
    
    function allocate_Token_to_player(uint token_index, bool clash_found) internal {
        while(clash_found){
            clash_found = check_clash(random_id);
            random_id = (uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, tokenCount))) % peopleCount) + 1;
        }
        Tokens[token_index] = Token(random_id, true);
    }
    
    function check_clash (uint randomid) internal view returns (bool) {
        for (uint256 i = 0; i <= tokenCount; i++){
            if (Tokens[i].id == randomid){
                return true;
            }
        }
        
        // we do not allow tokens to be passed to deactivated players
        // This code here could potentially cause the browser to enter into a state of script take too long to load
        if (Players[randomid].active == false){
            return true;
        }
        
        return false;
    }
    
    // uncomment this part during deployment
    // function proof_of_work () internal view returns (uint){
    //     uint random_number = 500;
    //     uint number_of_tries = 0;
    //     while (random_number > 5){
    //         random_number = (uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, random_number))) % 10) + 1;
    //         number_of_tries = number_of_tries + 1;
    //     }
    //     return number_of_tries;
    // }
    
    
    function transfer_to_another_person (uint token_index, uint mul_factor, bool clash_found) internal {
        uint256 current_balance = Players[Tokens[token_index].id].balance;
        if (current_balance > mul_factor){
            Players[Tokens[token_index].id].balance = current_balance - mul_factor; // minus off player balance from proof of work
            
            // transfer token to the next player
            while(clash_found){
                clash_found = check_clash(random_id);
                random_id = (uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, tokenCount))) % peopleCount) + 1;
            }
            Tokens[token_index].id = random_id; // transfer token to the next player
        }else{
            // deactivate token and player
            Players[Tokens[token_index].id].balance = 0;
            Players[Tokens[token_index].id].active = false;
            Tokens[token_index].active = false;
        }
    }
    
    function is_it_game_over () public view returns (bool) {
        for (uint256 i = 0; i <= tokenCount; i ++){
            // the game is not over if there are still active tokens
            if (Tokens[i].active == true){
                return false;
            }
        }
        return true;
    }
    
    // Uncomment only for deployment
    //Register funciton, reqires real eth to join 
    // function Register() external payable{
    //     require(msg.value == 1 ether, "Incorrect amount"); 
    //     emit Registration("Registration success, you have now joined the game!");
    //     addPlayer(msg.sender);
    // }
    // Uncomment only for deployment
    // function check_balance() public view returns(uint256){
    //     return Players[check_player_index()].balance;
    // }
    // function check_player_index()private view returns(uint32){
    //     for(uint32 i=1;i<peopleCount+1;i++){
    //         if (Players[i].id ==msg.sender){
    //             return i;
    //         }
    //     }
    //     return 0;
    // }
    // Uncomment only for deployment
    // function pay_transfer(uint256 amount)public{
    //     uint32 index =check_player_index();
    //     require(Players[index].balance>=amount,"Insufficient funds");
    //     Players[index].balance-=amount;
    //     current_pool+=amount;
    // }
    
    //////////////////// helper Functions End /////////////////////////
    
}