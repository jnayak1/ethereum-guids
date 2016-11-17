pragma solidity ^0.4.2;

contract OSFGuids {
    
    address public creator;
    
    struct Hash {
        uint updates;
        bytes32 value;
    }
    
    mapping(bytes5 => Hash) guidMap;
    
    function OSFGuids(){
        creator = msg.sender;
    }
    
    modifier isCreator {
        if(msg.sender != creator)
            throw;
        _;
    }
    
    function addGuid(bytes32 guid) 
        isCreator
    {
        
    }
}