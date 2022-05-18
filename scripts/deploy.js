const { expect } = require("chai");
const { ethers } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contracts with the account: " + deployer.address);


  console.log("Deploy NodeERC1155 Token");
  const NODE = await ethers.getContractFactory('RarityNFT');
  const node = await NODE.deploy();
  console.log("NFT deployed on ", node.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
