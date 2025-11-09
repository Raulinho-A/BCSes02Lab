// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MyNFT is ERC721 {
    constructor() ERC721("MyNFT", "MNFT") {}

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://QmFolderDeMisNFTs/";
    }

    function mint(address to, uint256 tokenId) external {
        _safeMint(to, tokenId); // tokenURI => ipfs://QmFolderDeMisNFTs/<tokenId>
    }
}