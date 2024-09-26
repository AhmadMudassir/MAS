const FlashProvider = artifacts.require("FlashProvider");
const TestUSDT = artifacts.require("TestUSDT");

module.exports = function (deployer) {
    deployer.then(async () => {
        const testUSDT = await TestUSDT.deployed();
        await deployer.deploy(FlashProvider, [testUSDT.address]);
    });
};
