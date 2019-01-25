pragma solidity >=0.4.21 <0.6.0;

contract Migrations {
    address public owner;
    // set the owner of the contracts
    uint public lastCompletedMigration;
    
    modifier restricted() {
        if (msg.sender == owner) _;
    }

    constructor() public {
        owner = msg.sender;
        // set msg.sender as the owner of the contract
    }
    
    function setCompleted(uint completed) public restricted {
        lastCompletedMigration = completed;
    }
    
    function upgrade(address newAddress) public restricted {
        Migrations upgraded = Migrations(newAddress);
        upgraded.setCompleted(lastCompletedMigration);
    }
}