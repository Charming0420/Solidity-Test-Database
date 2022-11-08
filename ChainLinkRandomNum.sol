// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

contract Random is VRFConsumerBaseV2 {

    VRFCoordinatorV2Interface COORDINATOR;
    uint256 public random;

    uint64 s_subscriptionId;
    address vrfCoordinator = 0x2Ca8E0C643bDe4C2E08ab1fA0da3401AdAD7734D;
    bytes32 s_keyHash = 0x79d3d8832d904592c0bf9818b621522c988bb8b0c05cdc3b15aea1b6e8db0c15;
    uint16 requestConfirmations = 3;
    uint32 callbackGasLimit = 80000;
    uint32 numWords = 1;

    uint256[] public requestIds;

    constructor(uint64 subscriptionId) VRFConsumerBaseV2(vrfCoordinator) {
        COORDINATOR = VRFCoordinatorV2Interface(vrfCoordinator);
        s_subscriptionId = subscriptionId;
    }

    function generateRandom() private view returns (uint256) {
        return uint256(
            keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp))
        );
    }

    function generateRandomFromChainlink() public returns (uint256 requestId) {
        requestId = COORDINATOR.requestRandomWords(
            s_keyHash,
            s_subscriptionId,
            requestConfirmations,
            callbackGasLimit,
            numWords
        );
    }

    function getAnswer() public view returns (uint256) {
        require(random != 0, "random not initialize.");
        return random % 1000;
    }

    function fulfillRandomWords(uint256 requestId, uint256[] memory randomWords) internal override {
        requestIds.push(requestId);
        random = randomWords[0];
    }
}