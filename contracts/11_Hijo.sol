// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

import "hardhat/console.sol";
import "./10_Padre.sol";

contract Perro is Animal {
    
    constructor() Animal("Perro") {
        
    }

    function hacerSonido() public pure override returns (string memory) {
        return "Guau guau";
    }

}