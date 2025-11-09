// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
contract MiniNFT is ERC721 {

    uint256 private _nextTokendId;

    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {
        
    }

    function mint(address to) public {
        _safeMint(to, _nextTokendId++);
    }
}