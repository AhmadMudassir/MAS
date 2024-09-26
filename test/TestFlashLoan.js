const TestUSDT = artifacts.require('TestUSDT');
const FlashProvider = artifacts.require('FlashProvider');
const FlashUser = artifacts.require('FlashUser');

contract('Flash Provider Test', async accounts => {

    it('flash balance should be 1 billion test USDT.', async () => {

        // get instance of test USDT.
        const testUSDT = await TestUSDT.deployed(); 

        // get instance of flash provider.
        const flashProvider = await FlashProvider.deployed(); 

        // use web3 to get the address of the first account. 
        const addresses  = await web3.eth.getAccounts(); 
        const first_address = addresses[0];

        // the first address has 1 billion tokens which we minted to test the flash provider. 
        // transfer to flash provider. 
        const tx = await testUSDT.transfer(flashProvider.address, '1000000000000000', {
            from: first_address
        });

        // check test USDT balance of flash provider.
        const balance = await testUSDT.balanceOf.call(flashProvider.address);

        // balance should be 1 billion.
        assert.equal(balance, '1000000000000000');
    });

    it('balance of flash provider should be 1 billion test USDT after executing through user contract.', async () => {
    
        // get instance of test USDT.
        const testUSDT = await TestUSDT.deployed(); 

        // get instance of flash provider.
        const flashProvider = await FlashProvider.deployed(); 

        // use web3 to get the address of the second account. 
        const addresses  = await web3.eth.getAccounts(); 
        const second_address = addresses[1];  
        
        // get flash user instance. 
        const flashUser = await FlashUser.deployed();

        // execute transaction.
        const tx = await flashUser.startFlash(
            flashProvider.address,
            '1000000000000000',
            testUSDT.address
        );

        // check test USDT balance of flash provider.
        const balance = await testUSDT.balanceOf.call(flashProvider.address);

        // balance should be 1 billion.
        assert.equal(balance, '1000000000000000');

    });
});
