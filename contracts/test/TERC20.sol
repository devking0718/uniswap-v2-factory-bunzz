// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TERC20 is ERC20, ERC20Burnable {
    constructor(uint _totalSupply) ERC20("Uniswap V2", "UNIV-V2") {
        _mint(msg.sender, _totalSupply);
    }
}

