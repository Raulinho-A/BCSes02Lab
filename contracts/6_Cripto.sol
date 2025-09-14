// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";

contract Cripto {
    address alice;

    constructor() {
        alice = 0x03C6FcED478cBbC9a4FAB34eF9f40767739D1Ff7;
    }

    event MensajeEncriptado (
        address from,
        address to,
        bytes mensajeEncriptado
    );

    function enviarMensaje(bytes memory _textoCrifrado) public {
        emit MensajeEncriptado(msg.sender, alice, _textoCrifrado);
    }

    // implementar mensaje desde String
    // ejemplo para agregar alumnos desde deploy y un metodo mas para ingresar el indice, y retorne los datos del alumno


}