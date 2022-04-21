const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Hello World", function () {
  const message = "Hello world !!!!";
  const messageSecond = "Bye world !!!!";
  let [accountA, accountB, accountC] = [];
  let helloWorld;
  let address0 = "0x0000000000000000000000000000000000000000";
  let uri = "sampleuri.com/";
  beforeEach(async () => {
    [accountA, accountB, accountC] = await ethers.getSigners();
    const HelloWorld = await ethers.getContractFactory("HelloWorld");
    helloWorld = await HelloWorld.deploy(message);
    await helloWorld.deployed();
  });

  it("Should return message correctly", async function () {
    expect(await helloWorld.printHelloWorld()).to.be.equal(message);
  });
});
