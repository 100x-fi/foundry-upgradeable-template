import { ethers, upgrades } from "hardhat";
import {
  UpgradeableErc20,
  UpgradeableErc20__factory,
} from "../../../typechain";

async function main() {
  console.log("Deploying UpgradeableErc20...");

  const [deployer] = await ethers.getSigners();

  const UpgradeableErc20 = new UpgradeableErc20__factory(deployer);
  const upgradeableErc20 = (await upgrades.deployProxy(UpgradeableErc20, [
    "UpgradeableErc20",
    "ERC20",
  ])) as UpgradeableErc20;
  await upgradeableErc20.deployTransaction.wait(1);

  console.log("UpgradeableErc20 deployed at", upgradeableErc20.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.log(error);
    process.exit(1);
  });
