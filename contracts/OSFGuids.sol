pragma solidity ^0.4.2;

contract OSFGuids {
    
    address public creator;
    
    struct Hash {
        uint updates;
        bytes32 value;
    }
    
    mapping(bytes5 => Hash) public guidMap;
    
    function OSFGuids(){
        creator = msg.sender;
    }
    
    modifier isCreator {
        if(msg.sender != creator)
            throw;
        _;
    }

    modifier doesNotExist(bytes5 guid) {
        if(!(guidMap[guid].value == bytes5(0x0)))
            throw;
        _;
    }
    
    function addGuid(bytes5 guid, bytes32 fileHash) 
        isCreator doesNotExist(guid)
    {
        guidMap[guid].updates = 0;
        guidMap[guid].value = fileHash;
    }
}