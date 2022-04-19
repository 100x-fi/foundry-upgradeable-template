// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import { BaseTest, console } from "./base/BaseTest.sol";

import { ProxyAdmin } from "../proxy/ProxyAdmin.sol";
import { TransparentUpgradeableProxy } from "../proxy/TransparentUpgradeableProxy.sol";
import { UpgradeableErc20 } from "../UpgradeableErc20.sol";

contract UpgradeableErc20_Test is BaseTest {
  address private constant TESTER1 = address(0x168);

  UpgradeableErc20 private token;

  function setUp() public {
    ProxyAdmin proxyAdmin = new ProxyAdmin();
    UpgradeableErc20 impl = new UpgradeableErc20();
    TransparentUpgradeableProxy proxy = new TransparentUpgradeableProxy(
      address(impl),
      address(proxyAdmin),
      abi.encodeWithSelector(
        bytes4(keccak256("initialize(string,string)")),
        "Token",
        "TKN"
      )
    );
    token = UpgradeableErc20(address(proxy));
  }

  function testCorrectness_mint(uint256 _amount) external {
    token.mint(TESTER1, _amount);
    assertEq(token.balanceOf(TESTER1), _amount);
  }
}
