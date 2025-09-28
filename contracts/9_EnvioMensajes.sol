// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

import "hardhat/console.sol";

contract EnvioMensajes {

    address public owner;

    struct Message {
        address from;
        address to;
        string content;
        uint timestamp;
    }

    Message[] public messages;

    event SentMessage(
        address from,
        address to,
        string content,
        uint timestamp
    );

    // modifier onlyOwner() {
    //     require(msg.sender == owner, "Solo el propietario puede realizar esta accion");
    //     _;
    // }

    constructor() {
        owner = msg.sender;
    }

    function sendMessage(address _to, string memory _content) public {
        Message memory newMessage = Message({
            from: msg.sender,
            to: _to,
            content: _content,
            timestamp: block.timestamp
        });

        messages.push(newMessage);
        emit SentMessage(msg.sender, _to, _content, block.timestamp);
    }

    function getMessage(uint _index) public view returns (Message memory) {
        require(_index < messages.length, "No existe el mensaje");
        Message memory m = messages[_index];

        return (m);
    }

    function getAllMessages() public view {
        for (uint256 i = 0; i < messages.length; i++) {
            console.log("Mensaje 1 a:", messages[i].to);
        }
    }


    function totalMessages() public view returns (uint) {
        return messages.length;
    }

}

// Dest_2: 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
// Dest_3: 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db