const PaySystem = artifacts.require("PaySystem");

module.exports = function (deployer) {
    deployer.deploy(PaySystem);
};
