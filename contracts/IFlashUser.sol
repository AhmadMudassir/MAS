// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

interface IFlashUser { 
    function flashCallback(uint amount, address token, bytes memory data) external;
}
