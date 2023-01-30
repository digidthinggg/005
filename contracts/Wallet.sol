// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./interfaces/ILayer.sol";

contract Wallet {
  address layerAddr;

  function setLayerAddress(address _layerAddr) public virtual {
    layerAddr = _layerAddr;
  }


  struct AmountMinMax {
    uint256 min;
    uint256 max;
  }

  struct Requirement {
    AmountMinMax amount;
    string[] tokensArr;
    Layer[][] layerFlow;
  }

  struct Transfer {
    uint256 transferNum;
    address receiver;
    uint256 amount;
    Requirement[] layerRequirements;
    bool executed;
  }

  // Pending transfers.
  Transfer[] transferQueue;


  event HandleLayerStartedEV();
  event HandleLayerSuccessEV();
  event HandleLayerFailureEV();


  function test() public virtual {
    require(address(layerAddr) != address(0), "layerAddr is not set");

    testInitTransferRequirements();

    // testInitAddLayerRequirements()
    // testInitRemoveLayerRequirements()

    // ILayer(layerAddr).executeLayer();
  }

  // Always have one set of requirements
  // But the requirements can differ because of amounts, tokens
  function testInitTransferRequirements() private {

    /*** transfer requirement a ***********************************************/

    AmountMinMax amountMinMaxA = AmountMinMax({
      min: 0,
      max: 100
    });

    string[] tokensA = [ "ETH", "USDC" ];

    Layer layerSeq0Num0 = new Layer("sms");
    Layer layerSeq0Num1 = new Layer("transaction");
    Layer layerSeq0Num2 = new Layer("email");

    Layer[] layerSeq0 = [ layerSeq0Num0, layerSeq0Num1, layerSeq0Num2 ];

    Layer layerSeq1Num0 = new Layer("sms");

    Layer[] layerSeq1 = [ layerSeq1Num0 ];

    Layer layerSeq2Num0 = new Layer("sms");
    Layer layerSeq2Num1 = new Layer("sms");

    Layer[] layerSeq2 = [ layerSeq2Num0, layerSeq2Num1 ];

    Layer[][] layerFlowA = [ layerSeq0, layerSeq1, layerSeq2 ];

    Requirement transferRequirementA = Requirement({
      amountMinMax: amountMinMaxA,
      tokens: tokensA,
      layerFlow: layerFlowA
    });

    transferRequirements.push(transferRequirementA);

    /*** transfer requirement a ***********************************************/


    /*** transfer requirement b ***********************************************/

    AmountMinMax amountMinMaxB = AmountMinMax({
      min: 90,
      max: 150
    });

    string[] tokensB = [ "USDT", "UNI" ];

    Layer layerSeq0Num0 = new Layer("sms");
    Layer layerSeq0Num1 = new Layer("transaction");
    Layer layerSeq0Num2 = new Layer("email");

    Layer[] layerSeq0 = [ layerSeq0Num0, layerSeq0Num1, layerSeq0Num2 ];

    Layer[][] layerFlowB = [ layerSeq0 ];

    Requirement transferRequirementB = Requirement({
      amountMinMax: amountMinMaxB,
      tokens: tokensB,
      layerFlow: layerFlowB
    });

    transferRequirements.push(transferRequirementB);

    /*** transfer requirement b ***********************************************/


    /*** transfer requirement c ***********************************************/

    AmountMinMax amountMinMaxC = AmountMinMax({
      min: 150,
      max: 300
    });

    string[] tokensC = [ "USDT", "UNI" ];

    Layer layerSeq0Num0 = new Layer("sms");
    Layer layerSeq0Num1 = new Layer("sms");
    Layer layerSeq0Num2 = new Layer("sms");

    Layer[] layerSeq0 = [ layerSeq0Num0, layerSeq0Num1, layerSeq0Num2 ];

    Layer[][] layerFlowC = [ layerSeq0 ];

    Requirement transferRequirementC = Requirement({
      amountMinMax: amountMinMaxC,
      tokens: tokensC,
      layerFlow: layerFlowC
    });

    transferRequirements.push(transferRequirementC);

    /*** transfer requirement c ***********************************************/
  }


  function handleLayerStarted() external {
    emit HandleLayerStartedEV();
  }

  function handleLayerSuccess() external {
    // dispatchNext
    emit HandleLayerSuccessEV();
  }

  function handleLayerFailure() external {
    emit HandleLayerFailureEV();
  }

  function executeTransfer() {
    //
  }
}
