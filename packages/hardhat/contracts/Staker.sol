// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "hardhat/console.sol";
import "./ExampleExternalContract.sol";

contract Staker {

    enum StakerState {
        ACCEPTING_FUNDS,
        OPEN_FOR_WITHDRAWAL,
        FULFILLED
    }

    ExampleExternalContract public exampleExternalContract;

    mapping(address => uint256) public balances;
    uint256 public constant threshold = 1 ether;
    uint256 public deadline = block.timestamp + 60 seconds;
    StakerState public state;

    event Stake(address staker, uint256 amount);

    modifier notCompleted() { // Make sure the external contract is not completed
        require(!exampleExternalContract.completed(), "The external contract is already completed!");
        _;
    }
    
    constructor(address exampleExternalContractAddress) {
        exampleExternalContract = ExampleExternalContract(
            exampleExternalContractAddress
        );
        state = StakerState.ACCEPTING_FUNDS;
    }

    receive() external payable {
        stake();
    }

    function execute() public notCompleted {
        require(
            state == StakerState.ACCEPTING_FUNDS,
            "This contract has already been executed"
        );

        //check if enough time has passed
        require(timeLeft() == 0, "Not enough time has passed!");
        // check if we have enough money staked
        if (address(this).balance >= threshold) {
            exampleExternalContract.complete{value: address(this).balance}();
            state = StakerState.FULFILLED;
        } else {
            state = StakerState.OPEN_FOR_WITHDRAWAL;
        }
    }

    function withdraw() public notCompleted {
        require(
            state == StakerState.OPEN_FOR_WITHDRAWAL,
            "You cant withdraw your funds!"
        );

        uint256 amountToWithdraw = balances[msg.sender];
        balances[msg.sender] = 0;
        (bool sent, bytes memory data) = (msg.sender).call{
            value: amountToWithdraw
        }("");
        require(sent, "Failed to send Ether");
    }

    function stake() public payable {
        require(
            state == StakerState.ACCEPTING_FUNDS,
            "This contract is not accepting funds anymore"
        );
        balances[msg.sender] += msg.value;
        emit Stake(msg.sender, msg.value);
    }

    function timeLeft() public view returns (uint256) {
        if (block.timestamp > deadline) {
            return 0;
        }
        return deadline - block.timestamp;
    }
}
