async function main() {
  const TestNFT = await ethers.getContractFactory(
    "contracts/TestNFT.sol:TestNFT"
  );

  // Start deployment, returning a promise that resolves to a contract object
  const testNFT = await TestNFT.deploy();
  console.log(
    ` Contract deployed to address: ${testNFT.address} \n--> Check address:  https://mumbai.polygonscan.com/address/${testNFT.address}`
  );
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
