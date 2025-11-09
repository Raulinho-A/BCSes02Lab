// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract PropioERC20 is ERC20 {

    constructor() ERC20("PetCareToken", "PCT")   {
        _mint(msg.sender, 1_000 * 10 ** decimals());
    }

    receive() external payable {}
    function donar() external payable {}
    function getBalance() external view returns (uint256) {
        return address(this).balance;         // balance de ETH del contrato
    }
}