// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";

contract Datos_primitivos {
    uint public saldo;
    bool private multiplo10;

    bool public pausado;

    address public owner;    

    bytes32 public clave;

    function incrementar(uint valor) public  {
        saldo += valor;

        multiplo10 = (saldo % 10 == 0);

        if  (multiplo10) {
            console.log(saldo, "es multiplo de 10");
        }
    }

    function asignarPausado(bool valor) public {
        pausado = valor;
    }

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "No eres el dueno del contrato");
        _;
    }

    function cambiarOwner(address _nuevoPropietario) public onlyOwner {
        owner = _nuevoPropietario;
    }

    function setClave(string memory _str) public onlyOwner {
        clave = keccak256(abi.encodePacked(_str)); //hola = 0x686f6c61

        // memory: Se va a crear en memoria una copia de _str y luego se usa
        // calldata: Se va a usar directamente _str
    }

}