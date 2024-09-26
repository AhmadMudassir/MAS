// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import '@openzeppelin/contracts/security/ReentrancyGuard.sol';

import './IFlashUser.sol';
import './IFlashProvider.sol';

contract FlashProvider is IFlashProvider, ReentrancyGuard {
    mapping(address => IERC20) public tokens;

    // accept list of supported tokens for providing flash operations.
    constructor(address[] memory _tokens) {
        for (uint i = 0; i < _tokens.length; i++) {
            tokens[_tokens[i]] = IERC20(_tokens[i]);
        }
    }

    function executeFlash(
        address callback,
        uint amount, 
        address _token, 
        bytes memory data
    ) external nonReentrant() override {
        IERC20 token = tokens[_token];
        
        // get balance of flash provider.
        uint originalBalance = token.balanceOf(address(this));

        require(address(token) != address(0), 'token not supported.');
        require(originalBalance >= amount, 'flash operation balance is not sufficient.');
        
        // transfer to user.
        token.transfer(callback, amount);

        // user smart contract will implement this callback
        // perform their arbitrage, liquidation etc. 
        IFlashUser(callback).flashLoanCallback(amount, _token, data);

        // require that the user repays the flash operation, 0% fee. 
        require(token.balanceOf(address(this)) == originalBalance, 'flash operation was not repaid.');
    }
}
