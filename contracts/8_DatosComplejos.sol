// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

import "hardhat/console.sol";

contract DatosComplejos {
    string private saludo = "Hola mundo";

    bytes public data;

    uint[] public numeros;

    string[] public nombres;

    struct Persona {
        string nombre;
        uint edad;
    }

    Persona[] public personas;

    function agregarPersonas(string memory _nombre, uint _edad) public {
        // directo
        personas.push(Persona(_nombre, _edad));

        // dos pasos
        // Persona memory persona = Persona(_nombre, _edad);
        // personas.push(persona);

    }

    function devolverPersona(uint pos) public view returns (string memory, uint) {
        return (personas[pos].nombre, personas[pos].edad);
    }



    function pintarNombres() public view {
        for (uint i = 0;  i < nombres.length; i++) {
            console.log(nombres[i]);
        }
    }

    function agregarNombres(string memory _nombre) public {
        nombres.push(_nombre);
    }

    function devolverTodosLosNombres() public view returns (string[] memory) {
        return nombres;
    }

    function agregarNumeros(uint _numero) public {
        numeros.push(_numero);
    }

    function devolverTodosLosNumeros() public view returns (uint[] memory) {
        return numeros;
    }

    function setSaludo(string memory _saludo) public {
        saludo = _saludo;
    }

    function getSaludo() public view returns (string memory) {
        return saludo;
    }

    function setData(bytes calldata _data) public {
        data = _data;
    }

    function devolverHexAsString() public view returns (string memory) {
        return string(data);
    }
}