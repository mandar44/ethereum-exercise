pragma solidity >=0.4.21 < 0.6.0;

// ERC20 Token
contract SimpleToken {

    //create an array with all balances
    mapping (address => uint) public balances;
    address public owner;
    uint public initialSupply = 5400000;

    // log the transfer coin from one address to another
    event TransferToken(address indexed _from, address indexed _to, uint amount);

    constructor () public payable {
        //require(msg.value == 350 ether, "350 (5.4 million tokens) ether initial funding required");
        /* set the owner to the creator of this contract */
        balances[tx.origin] = initialSupply;
    }

    // send coin from account to account and return amount of tokens transfered
    function transferCoin(address reciever, uint amount) public returns (uint token) {
        // If the amount is more than what user is trying to send, return sufficient = false
        // amount is in Eth, convert to tokens to sent to acc
        uint tokens = convertToTokens(amount, 15400);
        bool valid = validateTransaction(tokens);

        if( valid == true ) {
            balances[msg.sender] -= tokens;
            balances[reciever] += tokens;
            emit TransferToken(msg.sender, reciever, tokens);
            return tokens;
        }
    }

    function validateTransaction (uint amount) public view returns (bool sufficient) {
        // check if sender has enough tokens to send to account
        if (balances[msg.sender] < amount) return false;
        else return true;
    }

    function convertToTokens(uint amount, uint conversionRate) public pure returns (uint convertedVal) {
        // multiply by the conversion rate to get value of tokens equivalent to amount of ether sent
        return amount * conversionRate;
    }

    // show account balance
    function getBalance(address addr) public view returns (uint256) {
        return balances[addr];
    }

}