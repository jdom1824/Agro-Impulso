// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

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
        _admin = msg.sender; // Define al creador como administrador
    }

    // Crear una nueva etapa del proyecto
    function createStage(string memory name, string memory description, string memory uri) public returns (uint256) {
        require(msg.sender == _admin, "ProjectStages: Only admin can create stages");
        uint256 newStageId = _tokenIdCounter;

        _safeMint(msg.sender, newStageId); // Minta el token
        _setTokenURI(newStageId, uri);    // Asigna URI con detalles
        stages[newStageId] = Stage(name, description, false, block.timestamp); // Registra la etapa

        _tokenIdCounter += 1;
        return newStageId;
    }

    // Marcar una etapa como completada
    function completeStage(uint256 stageId) public {
        require(msg.sender == _admin, "ProjectStages: Only admin can complete stages");
        require(_exists(stageId), "ProjectStages: Stage does not exist");
        require(!stages[stageId].completed, "ProjectStages: Stage already completed");

        stages[stageId].completed = true;
        stages[stageId].timestamp = block.timestamp; // Actualiza el timestamp
    }

    // Función para actualizar el administrador
    function updateAdmin(address newAdmin) public {
        require(msg.sender == _admin, "ProjectStages: Only admin can update admin");
        _admin = newAdmin;
    }

    // Sobrescribir para restringir transferencias de tokens ERC-721
    function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal override {
        require(from == address(0) || to == address(0), "ProjectStages: Tokens are non-transferable");
        super._beforeTokenTransfer(from, to, tokenId);
    }
}
