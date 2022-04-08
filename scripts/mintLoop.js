require("dotenv").config();

const API_URL_MUMBAI = process.env.API_URL_MUMBAI;

// 2 address nay la co dinh, cua ben mint NFT
const PUBLIC_KEY = process.env.PUBLIC_KEY;
const PRIVATE_KEY = process.env.PRIVATE_KEY;
const CONTRACT_ADDRESS = process.env.CONTRACT_ADDRESS;

// const { createAlchemyWeb3 } = require("@alch/alchemy-web3");
// const web3 = createAlchemyWeb3(API_URL_MUMBAI);
var Web3 = require("web3");
var web3 = new Web3(API_URL_MUMBAI);

const contract = require("../artifacts/contracts/TestNFT.sol/TestNFT.json");
const contractAddress = CONTRACT_ADDRESS;
//contract test mint cu
// 0x68cDA7fbdA90b3837D81B05cDEEeD6715496Bfb9
const hashPinataIPFS = "QmbXx5NHb1KSsvfLmiNj8gzXBD7tBPARmmcskAbsKZkC1w";
const nftContract = new web3.eth.Contract(contract.abi, contractAddress);

async function mintNFT(tokenURIs, amount) {
  // for (let i = 0; i <= tokenURIs.length; i++) {}
  const nonce = await web3.eth.getTransactionCount(PUBLIC_KEY, "latest"); //get latest nonce

  let gasLimit = 150000 * amount; //uoc luong khoang 130->150k/1 NFT

  console.log(`--> ${amount} NFT`);
  //check gaslimit
  console.log(`--> ${gasLimit} gas limit`);
  //the transaction
  const tx = {
    from: PUBLIC_KEY,
    to: contractAddress,
    nonce: nonce,
    gas: gasLimit, //gas limit
    data: nftContract.methods
      .mintNFT(PUBLIC_KEY, tokenURIs, amount)
      .encodeABI(),
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

const arrMetadata = `https://gateway.pinata.cloud/ipfs/QmWLpjkC1pf8HfTUSvRJhH85e98xwdjQEq2yVuPQNrkkFJ/1.json`;
mintNFT(arrMetadata, 5);

// https://gateway.pinata.cloud/ipfs/QmNTNbzpWcJrj8sE7GyZgiEUu6zXwDCkiRKRwcxP1334bj
// https://gateway.pinata.cloud/ipfs/QmaUSn1NumUAfeN7MnH7PTbwuXcNtAhbfn7ScRk81eyEvG
// https://gateway.pinata.cloud/ipfs/QmbJoYNw6ntyL6aTsDDNNa3vMADo9shx7YnpXXppKC7vxt

// "https://gateway.pinata.cloud/ipfs/QmQe9zdQFw17ZfpskVbUvyQ8FRXimcdoz1dPujhGRK3Xbn",
// "https://gateway.pinata.cloud/ipfs/QmQ8t8VVu5dDtFcSkDuBoV6Cq7DwJBTWD11STy8nXfC7DD",
// "https://gateway.pinata.cloud/ipfs/QmP14K3jpBAWs2iYHiqvnGgBY9QxVzdw9P21SViKbTHRNC",
// "https://gateway.pinata.cloud/ipfs/QmX6jzqdGXkDfURQrZqwsQUftmGmpZNXcedJoMUync4DFc",
// "https://gateway.pinata.cloud/ipfs/QmXeHxoYvSm4SKe2vRWiijyH5KCiTG4qvvPHdRyevGEVK6",
// "https://gateway.pinata.cloud/ipfs/QmaAYZbSSmir5qArwP8tnrSR4nqt1ccmZg2qe3EdtwJEkD",
// "https://gateway.pinata.cloud/ipfs/QmVWkQMA1pW55s7PRAFNJheRh8GwJxrQkYdzPpJQT5Vj5w",
