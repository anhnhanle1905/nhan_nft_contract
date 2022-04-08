async function main() {
  const SimpleNftLowerGas = await ethers.getContractFactory(
    "SimpleNftLowerGas"
  );

  // Start deployment, returning a promise that resolves to a contract object
  const simpleNftLowerGas = await SimpleNftLowerGas.deploy();
  console.log(
    ` Contract deployed to address: ${simpleNftLowerGas.address} 
    \n--> Check address:  https://mumbai.polygonscan.com/address/${simpleNftLowerGas.address}`
  );
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
