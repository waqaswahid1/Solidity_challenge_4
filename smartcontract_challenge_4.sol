pragma solidity ^0.6.0;

contract SmartBank {
    uint8 public clientCount;
    mapping (address => uint) public balances;
    address public owner;

  
    event LogDepositMade(address indexed accountAddress, uint amount);

    
    constructor() public payable {
        require(msg.value == 10 ether, "10 ether initial funding required");
        owner = msg.sender;
        clientCount = 0;
    }

    
    function enroll() public returns (uint) {
        if (clientCount < 3) {
            clientCount++;
            balances[msg.sender] = 10 ether;
        }
        return balances[msg.sender];
    }

    
    function deposit() public payable returns (uint) {
        balances[msg.sender] += msg.value;
        emit LogDepositMade(msg.sender, msg.value);
        return balances[msg.sender];
    }

    
    function withdraw(uint withdrawAmount) public returns (uint remainingBal) {
        
        if (withdrawAmount <= balances[msg.sender]) {
            balances[msg.sender] -= withdrawAmount;
            msg.sender.transfer(withdrawAmount);
        }
        return balances[msg.sender];
    }
}