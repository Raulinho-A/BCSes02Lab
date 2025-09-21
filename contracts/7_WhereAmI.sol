// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract WhereAmI {
    uint256 public zipCode;
    address public owner;
    address payable public destAccount;
    uint private creationTime;

    constructor(uint256 _zipCode) {
        zipCode = _zipCode;
        owner = msg.sender;
        destAccount = payable(0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2); // ejemplo
        creationTime = block.timestamp;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "No es el propietario");
        _;
    }

    function setZipCode(uint256 _newZipCode) public onlyOwner payable {
        require(msg.value >= 0.01 ether, "El valor debe ser minimo 0.01");
        require(_newZipCode >= 10000 && _newZipCode <= 99999, "El codigo postal debe tener 5 digitos");
        zipCode = _newZipCode;
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function withdraw() public onlyOwner {
        require(block.timestamp > creationTime + 1 minutes, "No puede retirar antes de que pase 1 minuto");
        destAccount.transfer(address(this).balance);
    }

    receive() external payable { }
}
