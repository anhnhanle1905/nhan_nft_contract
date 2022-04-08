/**
 * @type import('hardhat/config').HardhatUserConfig
 */
require("dotenv").config();
require("@nomiclabs/hardhat-ethers");
const { API_URL_MUMBAI, PRIVATE_KEY } = process.env;
module.exports = {
  solidity: "0.8.0",
  defaultNetwork: "mumbai",
  networks: {
    hardhat: {},
    // testnet: {
    //    url: API_URL,
    //    accounts: [`0x${PRIVATE_KEY}`]
    // }
    mumbai: {
      url: API_URL_MUMBAI,
      chainId: 80001,
      accounts: [`0x${PRIVATE_KEY}`],
      gasPrice: 20000000000,
    },
    testnet: {
      url: "https://data-seed-prebsc-1-s1.binance.org:8545",
      chainId: 97,
      gasPrice: 20000000000,
      accounts:
        process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
    },
    mainnet: {
      url: "https://bsc-dataseed.binance.org/",
      chainId: 56,
      gasPrice: 20000000000,
      accounts:
        process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
    },
  },
};
