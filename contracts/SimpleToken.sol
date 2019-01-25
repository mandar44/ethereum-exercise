pragma solidity >=0.4.21 < 0.6.0;

// ERC20 Token
contract SimpleToken {

    //create an array with all balances
    mapping (address => int) public balances;
    address payable public owner;
    int public initialSupply = 5400000; // initialize supply to 5400000 units (tokens)

    // log the transfer coin from one address to another
    event TransferToken(address indexed _from, address indexed _to, int amount);

    constructor () public payable {
        /* set the owner to the creator of this contract */
        balances[msg.sender] = initialSupply;
    }

    // send coin from account to account and return amount of tokens transfered
    function transferCoin(address reciever, int amount) public returns (int token) {
        // If the amount is more than what user is trying to send, return sufficient = false
        // amount is in Eth, convert to tokens to sent to acc
        int tokens = convertToTokens(amount, 15400);
        bool valid = validateTransaction(tokens);

        if( valid == true ) {
            balances[msg.sender] -= int(tokens);
            balances[reciever] += int(tokens);
            emit TransferToken(msg.sender, reciever, tokens);
            return int(tokens);
        } else {
            // transaction invalid, return 0
            return 0;
        }
    }

    function validateTransaction (int amount) public view returns (bool sufficient) {
        // check if sender has enough tokens to send to account
        if (balances[msg.sender] < amount) return false;
        else return true;
    }

    function convertToTokens(int amount, int conversionRate) public pure returns (int convertedVal) {
        // multiply by the conversion rate to get value of tokens equivalent to amount of ether sent
        return amount * conversionRate;
    }

    // show account balance
    function getBalance(address addr) public view returns (int) {
        return int(balances[addr]);
    }

    // get contract description
    function getContractDescription() public view returns (address) {
        return address(msg.sender);
    }

}