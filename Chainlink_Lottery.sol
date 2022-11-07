// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

//import chainlink VRF所需套件
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

contract lottery is VRFConsumerBaseV2{
    //宣告變數
    address public _owner ;
    uint256 public enterNum = 0;
    uint256 winnerNum = 0;
    address [] public enterPerson;
    address payable winner ;
    uint256 public balance = address(this).balance;


    //ChainlinkVRF宣告變數
    VRFCoordinatorV2Interface COORDINATOR;
    uint256 public random;
    uint64 s_subscriptionId;
    address vrfCoordinator = 0x2Ca8E0C643bDe4C2E08ab1fA0da3401AdAD7734D;
    bytes32 s_keyHash = 0x79d3d8832d904592c0bf9818b621522c988bb8b0c05cdc3b15aea1b6e8db0c15;
    uint16 requestConfirmations = 3;
    uint32 callbackGasLimit = 500000;
    uint32 numWords = 1;
    uint256[] public requestIds;

    //event
    event WinnerLog (address indexed winner,uint256 indexed winMoney);

    //modifier
    modifier onlyOwner() {
        require(msg.sender==_owner,"ERROR : You are not owner!");
        _;
    }

    //Constructor
    constructor(uint64 subscriptionId) VRFConsumerBaseV2(vrfCoordinator){
        _owner = msg.sender;
        //VRF的constructor
        COORDINATOR = VRFCoordinatorV2Interface(vrfCoordinator);
        s_subscriptionId = subscriptionId;
    }

    //投入資金Function 應該加入可以輸入錢的function
    function enter() public payable{
        require(msg.value >= 1000000000000000, "ERROR : Too low to enter this game!");
        require(msg.sender.balance > msg.value);
        enterPerson.push(msg.sender);
        enterNum += 1 ;    
    }

    receive() external payable {}
    fallback() external payable {}

    //透過chainlink VRF取得隨機數
    function getRandomNumber() internal onlyOwner{
        generateRandomFromChainlink();
        winnerNum = getAnswer();
    }

    //挑出這期幸運得主
    function pickWinner() external onlyOwner{
        require(address(this).balance > 10000000000000000, "ERROR : The prize pool is too small to pick Winner!");
        getRandomNumber();
        winner = payable (enterPerson[winnerNum]) ;
        _transferWinnerMoney(winner);
        emit WinnerLog(winner,address(this).balance);
        delete enterPerson;
        enterNum = 0;
    }

    //這期累積總獎金額(ether)
    function currentPrize() public view returns(uint256){
        return address(this).balance;
    }

    function _transferWinnerMoney(address _winner) internal {
        payable (_winner).transfer(address(this).balance);
    }


    // --------------------------------------------------------------------------------------------------------
    //以下為VRF所需Function
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
        return random % enterNum; //從買樂透的人數中隨機取一值
    }


    function fulfillRandomWords(uint256 requestId, uint256[] memory randomWords) internal override {
        requestIds.push(requestId);
        random = randomWords[0];
    }

}