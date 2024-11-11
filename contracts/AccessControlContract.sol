// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AccessControlContract {
    struct Stakeholder {
        uint256 stakedTokens;
        bool isValidator;
    }

    mapping(address => Stakeholder) public stakeholders;
    uint256 public constant MIN_STAKE = 100; // minimum token stake to become validator

    event StakeAdded(address indexed doctor, uint256 amount);
    event ValidationReward(address indexed doctor, uint256 reward);

    // Stake tokens to become a validator
    function stakeTokens() public payable {
        require(msg.value >= MIN_STAKE, "Minimum stake required");
        stakeholders[msg.sender].stakedTokens += msg.value;
        stakeholders[msg.sender].isValidator = true;
        emit StakeAdded(msg.sender, msg.value);
    }

    // Reward validators for successful transaction validation
    function rewardValidator(address _doctor) public {
        require(stakeholders[_doctor].isValidator, "Not a validator");
        uint256 reward = stakeholders[_doctor].stakedTokens / 10; // 10% reward
        payable(_doctor).transfer(reward);
        emit ValidationReward(_doctor, reward);
    }
}
