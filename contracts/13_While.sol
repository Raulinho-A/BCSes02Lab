// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;
import "hardhat/console.sol";

contract MyWhile {

    // sumar 'n' primeros numeros pares en un variable
    // suma 'n' primeros numeros impares en otra variable
    // retorna ambas sumatorias

    function sumNumbers(uint n) public pure returns (uint, uint) {
        uint sumaPares = 0;
        uint sumaImpares = 0;

        uint i = 1;
        uint countPares = 0;
        uint countImpares = 0;

        while (countPares < n || countImpares < n) {
            if (i % 2 == 0) {
                console.log("Sumar par: ", i);
                sumaPares += i;
                countPares++;
            } else if (i % 2 != 0 && countImpares < n) {
                console.log("Sumar impar: ", i);
                sumaImpares += i;
                countImpares++;
            }
            i++;
        }

        return (sumaPares, sumaImpares);
    }

    function sumPares(uint n) public pure returns (uint) {
        uint sumaPares = 0;

        uint i = 1;
        uint countPares = 0;

        while (countPares < n) {
            if (i % 2 == 0) {
                console.log("Sumar par: ", i);
                sumaPares += i;
                countPares++;
            } 
            i++;
        }

        return sumaPares;
    }

    function sumImpares(uint n) public pure returns (uint) {
        uint sumaImpares = 0;

        uint i = 1;
        uint countImpares = 0;

        while (countImpares < n) {
            if (i % 2 != 0) {
                console.log("Sumar impar: ", i);
                sumaImpares += i;
                countImpares++;
            } 
            i++;
        }

        return sumaImpares;
    }
}