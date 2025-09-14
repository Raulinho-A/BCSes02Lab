// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MiContrato {
    uint256 private codigo;
    address private owner;

    event CodigoModificado(uint256 codigoAnterior, uint256 codigoNuevo);

    constructor() {
        codigo = 6918;
        owner = msg.sender;
        console.log("la direccion del propietario es: ", owner);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "No eres el dueno del contrato");
        _;
    }

    function getCodigo() public view returns (uint) {
        return codigo;
    }

    function setCodigo(uint _codigo) public onlyOwner {
        uint256 codigoAnterior = codigo; 
        codigo = _codigo;

        console.log("Acaba de modificar el codigo");
        emit CodigoModificado(codigoAnterior, _codigo);
    }

}