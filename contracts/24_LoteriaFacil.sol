// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Loteria is ERC20, Ownable {

    // Contrato NFT de boletos
    MainERC721 public nft;

    // Cuenta del ganador (posteriormente se determinara)
    address public ganador;


    constructor() ERC20("La Tinka Peru", "LTP") Ownable(msg.sender) {

        _mint(address(this), 1000);
        // Desplegar contrato NFT
        nft = new MainERC721();
    }

    // ============
    // Funciones Gestion de Tokens
    // ============
    function mint(uint256 _nuevosTokens) public onlyOwner {
        _mint(address(this), _nuevosTokens);
    }
        // Compra de tokens pagando en ether
    function compraTokens(uint256 _numTokens) public payable {
        uint256 costo = precioTokens(_numTokens);
        require(msg.value >= costo, "No te alcanza para pagarlo");

        uint256 stock = balanceOf(address(this));
        require(_numTokens <= stock, "No hay suficiente stock de tokens");

        uint256 cambio = msg.value - costo;
        if (cambio > 0) {
            payable(msg.sender).transfer(cambio);
        }        
        _transfer(address(this), msg.sender, _numTokens);
    }

    function precioTokens(uint256 _numTokens) pure internal returns (uint256) {
        return _numTokens * 1 ether;
    }

   // Devolver tokens a cambio de ether
    function devolverTokens(uint256 _numTokens) public {
        require(balanceOf(msg.sender) >= _numTokens, "No tienes suficientes tokens");

        uint256 valor = precioTokens(_numTokens);
        require(address(this).balance >= valor, "SC sin fondos suficientes");

        _transfer(msg.sender, address(this), _numTokens);
        payable(msg.sender).transfer(valor);
    }




    function balanceEthersSC() public view returns (uint256) {
        return address(this).balance;
    }

        // =======================
    // Gestion de la Loteria
    // =======================

    // Contador secuencial de boletos
    uint256 public contadorBoletos = 0;

    // Precio del boleto en tokens
    uint256 public precioBoleto = 5;

    // Propietario -> lista de boletos
    mapping(address => uint256[]) private boletosPorPersona;

    // Lista total de boletos vendidos
    uint256[] public boletosVendidos;


    function comprarBoleto(uint256 _numBoletos) public {
        require(_numBoletos > 0, "Debes comprar al menos un boleto");

        uint256 costo = _numBoletos * precioBoleto;
        require(balanceOf(msg.sender) >= costo, "No tienes tokens suficientes");

        // Transferir tokens al contrato
        _transfer(msg.sender, address(this), costo);

        // Generar boletos secuenciales y mintear NFTs
        for (uint256 i = 0; i < _numBoletos; i++) {
            contadorBoletos++; // 1, 2, 3, ...
            uint256 nuevoBoleto = contadorBoletos;

            boletosPorPersona[msg.sender].push(nuevoBoleto);
            boletosVendidos.push(nuevoBoleto);

            // Mintear el NFT correspondiente
            nft.safeMint(msg.sender, nuevoBoleto);
        }
    }


    function tusBoletos(address _propietario) public view returns (uint256[] memory) {
    }
    
    // =======================
// Sorteo de la loteria
// =======================

function sortearGanador() public onlyOwner {
    uint256 total = boletosVendidos.length;
    require(total > 0, "No hay boletos vendidos");

    // Elegimos un indice aleatorio entre 0 y total-1
    uint256 indice = uint256(
        keccak256(
            abi.encodePacked(block.timestamp, msg.sender, total)
        )
    ) % total;

    // Número de boleto ganador
    uint256 boletoGanador = boletosVendidos[indice];

    // Dueño actual del boleto (segun el NFT)
    address ganadorLocal = nft.ownerOf(boletoGanador);
    ganador = ganadorLocal; // guardamos en el estado

    // Repartimos el Ether del contrato:
    uint256 fondo = address(this).balance; // en wei
    require(fondo > 0, "No hay fondos para repartir");

    uint256 premio = (fondo * 90) / 100;   // 90% para el ganador
    uint256 comision = fondo - premio;     // 10% para el owner

    payable(ganadorLocal).transfer(premio);
    payable(owner()).transfer(comision);
}

}

contract MainERC721 is ERC721 {

    constructor() ERC721("La Tinka NFT", "LTN") {

    }

    function safeMint(address _propietario, uint256 _boleto) external {
        
        _safeMint(_propietario, _boleto);
    }
}