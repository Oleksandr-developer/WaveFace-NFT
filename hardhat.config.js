require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");
require('@openzeppelin/hardhat-upgrades');
require("dotenv").config();
const pk_deploy = process.env.PK_DEPLOYER;



module.exports = {
  solidity: {
    version: "0.8.11",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  networks: {
    localhost: {
      url: "http://127.0.0.1:7545",
    },
    hardhat: {},
    rinkeby: {
      url: "https://rinkeby.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161",
      chainId: 4,
      gasPrice: 8000000000,
      gas: 12450000,
      accounts: [`846c6d26e386558a9071cf226867e766db7923c34ce4988396cd7e686aa48ba9`],
    },
  },
  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://etherscan.io/
    apiKey: "VDUMEYDH78DIDN8XIK2SSB1WS3KYT9HR8V",
  },
};
