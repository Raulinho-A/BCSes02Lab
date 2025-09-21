// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract GasConsume {
    uint[] public numeros;

    mapping(address => uint) public balances;

    function guardarEnMapping(uint _valor) public {
        balances[msg.sender] = _valor;
    }

    function llenarArray(uint _cantidad) public {
        for (uint i = 0; i < _cantidad; i++) {
            numeros.push(i);
        }
    }

    function verNumeros(uint _index) public view returns (uint) {
        return numeros[_index];
    }
}