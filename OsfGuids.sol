pragma solidity ^0.4.2;

contract OSFGuids {
    
    address public creator;
    
    struct Hash {
        uint updates;
        bytes32[] value;
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

    modifier hashDoesNotExist(bytes5 guid) {
        if(!(guidMap[guid].value[0] == bytes5(0x0)))
            throw;
        _;
    }

    modifier hashExists(bytes5 guid) {
        if((guidMap[guid].value[0] == bytes5(0x0)))
            throw;
        _;
    }
    
    function addGuid(bytes5 guid, bytes32 fileHash) 
        isCreator hashDoesNotExist(guid)
    {
        guidMap[guid].updates = 0;
        guidMap[guid].value[0] = fileHash;
    }

    function updateGuid(bytes5 guid, bytes32 fileHash)
        isCreator hashExists(guid)
    {
        uint newUpdates = guidMap[guid].updates + 1;
        guidMap[guid].updates = newUpdates;
        guidMap[guid].value[newUpdates] = fileHash;
    }
}