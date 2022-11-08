// Import ethers from Hardhat package
const { ethers } = require("hardhat");

async function main() {
  /*
EventContract is the smart contract which is being deployed.
*/
  const EventContract = await ethers.getContractFactory("EventContract");

  // here we deploy the contract
  const deployedEventContract = await EventContract.deploy();

  // wait for the contract to deploy
  await deployedEventContract.deployed();

  // print the address of the deployed contract
  console.log("NFT Contract Address:", deployedEventContract.address);
}

// Call the main function and catch if there is any error
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });