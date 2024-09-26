const TestUSDT = artifacts.require("TestUSDT");

module.exports = function (deployer) {
  deployer.deploy(TestUSDT);
};
