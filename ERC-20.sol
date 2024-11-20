// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract StakeholderToken is ERC20 {
    address private _admin;

    constructor(uint256 initialSupply) ERC20("StakeholderToken", "STK") {
        _admin = msg.sender; 
        _mint(msg.sender, initialSupply); 
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount) internal override {
        require(from == address(0) || to == address(0), "StakeholderToken: Tokens are non-transferable");
        super._beforeTokenTransfer(from, to, amount);
    }

    function distribute(address stakeholder, uint256 amount) public {
        require(msg.sender == _admin, "StakeholderToken: Only admin can distribute tokens");
        _transfer(msg.sender, stakeholder, amount);
    }

    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    function updateAdmin(address newAdmin) public {
        require(msg.sender == _admin, "StakeholderToken: Only admin can update admin");
        _admin = newAdmin;
    }
}
