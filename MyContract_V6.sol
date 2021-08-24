pragma solidity >=0.4.24 < 0.9.0;

contract MyContract_V6{
    mapping (address => uint256) public balances;
    address payable wallet;
    
    event Purchase(address indexed _buyer, uint256 _amount);
    
    function() external payable {
        buyToken();
    }
    
    function buyToken() public payable{
        balances[msg.sender] += 1;
        wallet.transfer(msg.value);
        emit Purchase(msg.sender, 1);
    }
    
    constructor(address payable _wallet) public {
        wallet = _wallet;
    }

}