pragma solidity ^0.4.24;

import "./SafeMath.sol";

contract TestTransfer {
    
    using SafeMath for uint32;
    
    mapping(address => uint32) wallet;
    mapping(address => uint32) txList;
    
    function hasTxToConfirm() public view returns(bool, uint) {
        return (txList[msg.sender] > 0, txList[msg.sender]);
    }
    
    function transfer(address to, uint32 amount) public {
        require(txList[to] == 0 && amount <= wallet[msg.sender] && amount > 0);
        wallet[msg.sender] = wallet[msg.sender].sub32(amount);
        txList[to] = amount;
    }
    
    function claim() public {
        require(txList[msg.sender] > 0);
        wallet[msg.sender] = wallet[msg.sender].add32(txList[msg.sender]);
        txList[msg.sender] = 0;
    }
    
    function increaseMoney() public {
        wallet[msg.sender] = wallet[msg.sender].add32(uint32(100));
    }
    
    function getWalletStatus() public view returns(uint) {
        return wallet[msg.sender];
    }
    
}
