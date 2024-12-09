// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract ProjectStages is ERC721URIStorage {
    uint256 private _tokenIdCounter;
    address private _admin;

    struct Stage {
        string name;
        string description;
        bool completed;
        uint256 timestamp;
    }

    mapping(uint256 => Stage) public stages;

    constructor() ERC721("ProjectStages", "PSTG") {
        _admin = msg.sender; 
    }

    // Crear una nueva etapa del proyecto
    function createStage(
        string memory name, 
        string memory description, 
        string memory uri
    ) 
        public 
        returns (uint256) 
    {
        require(msg.sender == _admin, "ProjectStages: Only admin can create stages");
        
        uint256 newStageId = _tokenIdCounter;
        _safeMint(msg.sender, newStageId); 
        _setTokenURI(newStageId, uri);    
        stages[newStageId] = Stage(name, description, false, block.timestamp); 

        _tokenIdCounter += 1;
        return newStageId;
    }

    // Marcar una etapa como completada
    function completeStage(uint256 stageId) public {
        require(msg.sender == _admin, "ProjectStages: Only admin can complete stages");
        require(stageId < _tokenIdCounter, "ProjectStages: Stage does not exist");
        require(!stages[stageId].completed, "ProjectStages: Stage already completed");

        stages[stageId].completed = true;
        stages[stageId].timestamp = block.timestamp; 
    }

    // Actualizar el administrador
    function updateAdmin(address newAdmin) public {
        require(msg.sender == _admin, "ProjectStages: Only admin can update admin");
        _admin = newAdmin;
    }
}
