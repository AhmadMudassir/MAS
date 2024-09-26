// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import './IFlashUser.sol';
import './IFlashProvider.sol';

contract FlashUser is IFlashUser { 

    IFlashProvider private provider; 

    function startFlash(
        address _provider, 
        uint amount, 
        address _token
    ) external { 
        provider = IFlashProvider(_provider);
        provider.executeFlash(address(this), amount, _token, bytes(''));
    }

    // the flash operation will call this function
    // perform arbitrage, liquidation etc in this function.
    // must repay flash operation.
    function flashCallback(uint amount, address _token, bytes memory data) external override {
        require(msg.sender == address(provider), 'only flash provider can execute callback.');
        
        // perform arbitrage, liquidation etc in this function.

        // repay. 
        IERC20(_token).transfer(address(provider), amount);

        // take profit to user EOA.
    }

}
