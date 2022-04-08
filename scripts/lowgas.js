require("dotenv").config();

const API_URL_MUMBAI = process.env.API_URL_MUMBAI;

// 2 address nay la co dinh, cua ben mint NFT
const PUBLIC_KEY = process.env.PUBLIC_KEY;
const PRIVATE_KEY = process.env.PRIVATE_KEY;

var Web3 = require("web3");
var web3 = new Web3(API_URL_MUMBAI);
const contract = require("../artifacts/contracts/SimpleNftLowerGas.sol/SimpleNftLowerGas.json");
const contractAddress = 0x325d5b5fd9174edc109eccf4b6956ad0defe88a6;
const nftContract = new web3.eth.Contract(contract.abi, contractAddress);

async function mintNFT() {
  // for (let i = 0; i <= tokenURIs.length; i++) {}
  const nonce = await web3.eth.getTransactionCount(PUBLIC_KEY, "latest"); //get latest nonce

  //the transaction
  const tx = {
    from: PUBLIC_KEY,
    to: contractAddress,
    nonce: nonce,
    gas: 500000, //gas limit
    data: nftContract.methods.setPaused(false).encodeABI(),
  };
  const signPromise = web3.eth.accounts.signTransaction(tx, PRIVATE_KEY);
  signPromise
    .then((signedTx) => {
      web3.eth.sendSignedTransaction(
        signedTx.rawTransaction,
        function (err, hash) {
          if (!err) {
            console.log(
              "The hash of your transaction is: ",
              hash,
              `\nCheck your transaction:  https://mumbai.polygonscan.com/tx/${hash}`
            );
          } else {
            console.log(
              "Something went wrong when submitting your transaction:",
              err
            );
          }
        }
      );
    })
    .catch((err) => {
      console.log(" Promise failed:", err);
    });
}
mintNFT();
