// SPDX-License-Identifier: MIT

pragma solidity 0.8.13;

import { Initializable } from "../lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol";
import { OwnableUpgradeable } from "../lib/openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol";
import { ERC20Upgradeable } from "../lib/openzeppelin-contracts-upgradeable/contracts/token/ERC20/ERC20Upgradeable.sol";

contract UpgradeableErc20 is OwnableUpgradeable, ERC20Upgradeable {
  function initialize(string memory _name, string memory _symbol)
    external
    initializer
  {
    OwnableUpgradeable.__Ownable_init();
    ERC20Upgradeable.__ERC20_init(_name, _symbol);
  }

  function mint(address _to, uint256 _amount) external onlyOwner {
    _mint(_to, _amount);
  }
}