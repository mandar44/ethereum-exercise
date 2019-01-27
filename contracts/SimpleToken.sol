pragma solidity >=0.4.21 < 0.6.0;
pragma experimental ABIEncoderV2;

// ERC20 Token
contract SimpleToken {

    //create an array with all balances
    mapping (address => int) public balances;
    address payable public owner;
    address[] transferedTo; // addresses of accounts that have tokens transfered to
    int public initialSupply = 5400000; // initialize supply to 5400000 units (tokens)

    // log the transfer coin from one address to another
    event TransferToken(address indexed _from, address indexed _to, int amount);

    constructor () public payable {
        /* set the owner to the creator of this contract */
        balances[msg.sender] = initialSupply;
    }

    // send coin from account to account and return amount of tokens transfered
    function transferCoin(address reciever, uint amount) public returns (int token) {

        // amount is in Eth, convert to tokens and check if sender has enough tokens
        int tokens = convertToTokens(amount, 15400);
        bool valid = validateTransaction(tokens);

        if( valid == true ) {
            balances[msg.sender] -= tokens;
            balances[reciever] += tokens;

            // add reciever account to array of accounts
            transferedTo.push(reciever);
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

    function convertToTokens(uint amount, int conversionRate) public pure returns (int convertedVal) {
        // multiply by the conversion rate to get value of tokens equivalent to amount of ether sent
        return int(amount) * conversionRate;
    }

    // show account balance
    function getBalance(address addr) public view returns (int) {
        return int(balances[addr]);
    }

    // get contract description
    function getContractDescription() public view returns (address) {
        return address(msg.sender);
    }

    // return all addresses that have tokens transfered to them
    function getAllEthAddresses() public view returns (address[] memory) {
        return transferedTo;
    }

}