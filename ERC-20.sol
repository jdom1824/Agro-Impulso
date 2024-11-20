// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract StakeholderToken is ERC20 {
    address private _admin;

    constructor(uint256 initialSupply) ERC20("StakeholderToken", "STK") {
        _admin = msg.sender; // Define al creador como administrador
        _mint(msg.sender, initialSupply); // Minta todos los tokens al administrador
    }

    // Los tokens no pueden ser transferidos
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal override {
        require(from == address(0) || to == address(0), "StakeholderToken: Tokens are non-transferable");
        super._beforeTokenTransfer(from, to, amount);
    }

    // Función para que el administrador distribuya tokens a los stakeholders
    function distribute(address stakeholder, uint256 amount) public {
        require(msg.sender == _admin, "StakeholderToken: Only admin can distribute tokens");
        _transfer(msg.sender, stakeholder, amount);
    }

    // Función para quemar tokens de un stakeholder
    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    // Permite al administrador actualizar el administrador en caso de necesidad
    function updateAdmin(address newAdmin) public {
        require(msg.sender == _admin, "StakeholderToken: Only admin can update admin");
        _admin = newAdmin;
    }
}
