// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

interface IFlashProvider { 
    function executeFlash(address callback, uint amount, address _token, bytes memory data) external;
}
