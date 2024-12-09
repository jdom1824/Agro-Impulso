// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenFungible is ERC20 {
    address private _admin;

    constructor(uint256 initialSupply) ERC20("FungibleToken", "FTK") {
        _admin = msg.sender;
        _mint(_admin, initialSupply);
    }

    // Función para que el admin distribuya tokens a otras direcciones
    function distribute(address recipient, uint256 amount) external {
        require(msg.sender == _admin, "TokenFungible: Only admin can distribute tokens");
        _transfer(_admin, recipient, amount);
    }

    // Función para quemar tokens (cualquiera puede quemar los suyos)
    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    // Actualizar administrador
    function updateAdmin(address newAdmin) external {
        require(msg.sender == _admin, "TokenFungible: Only admin can update admin");
        _admin = newAdmin;
    }

    // Obtener el admin actual
    function admin() external view returns (address) {
        return _admin;
    }
}
