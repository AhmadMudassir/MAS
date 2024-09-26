// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

contract TestUSDT is ERC20 {

    constructor() ERC20('Test USDT', 'USDT') {
        // mint 1 billion Test USDT to contract creator.
        _mint(msg.sender, 1000000000000000);
    }

    /// @dev set decimals to 6. 
    function decimals() public view virtual override returns (uint8) {
        return 6;
    }
}
