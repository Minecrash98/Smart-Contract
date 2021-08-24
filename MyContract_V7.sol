pragma solidity >=0.4.24 < 0.9.0;

contract ERC20Token{
    string public name;
    mapping (address => uint256) public balances;
    
    function mint() public {
        balances [tx.origin] ++;
    }
    
    constructor (string memory _name) public{
        name = _name;
    }
}

contract MyToken is ERC20Token{
    string public symbol;
    address [] public owners;
    uint256 public ownerCount;
    
    constructor(string memory _name, string memory _symbol)
    
    ERC20Token(_name) public{
        symbol = _symbol;
    }
    
    function mint() public {
        super.mint();
        ownerCount ++;
        owners.push(msg.sender);
    }
}


contract MyContract_V7{
    ERC20Token public token;
    address payable wallet;
    
    constructor (address payable _wallet, ERC20Token _token) public {
        wallet = _wallet;
        token = _token;
    }
    
    function buyToken() public payable {
        token.mint();
        // ERC20Token(address(token)).mint();
        // ERC20Token _token = ERC20Token(address(token));
        // _token.mint();
        wallet.transfer(msg.value);
    }
}