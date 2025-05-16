// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/structs/EnumerableSet.sol";


contract WeightedVoting {
    using EnumerableSet for EnumerableSet.AddressSet;

    uint public maxSupply;

    error TokensClaimed();
    error AllTokensClaimed();
    error NoTokensHeld();
    error QuorumToHigh(uint _quorumAmount);
    error AlreadyVoted();
    error VotingClosed();

    struct Issue {
        EnumerableSet.AddressSet voters;
        string issueDesc;
        uint votesFor;
        uint votesAgainst;
        uint votesAbstain;
        uint totalVotes;
        uint quorum;
        bool passed;
        bool closed;
    }

    Issue[] issues;
    enum Vote {
        AGAINST,
        FOR,
        ABSTAIN
    }

    uint numberOfIssues = 0;

    uint totalClaimed;

    address[] claimers;

    mapping(address => uint) public balances;


    constructor() { //ERC20(_name, _symbol) {
        maxSupply = 1000000;
        // Issue storage burned = issues[0];
        //transfer(address(0), 0);
        maxSupply -= 1;
        // numberOfIssues += 1;
    }


    function claim() public {
        if (totalClaimed == maxSupply) {
            revert AllTokensClaimed();
        }
        bool hasAlreadyClaimed = false;
        for (uint i = 0; i < claimers.length; i++) {
            if (msg.sender == claimers[i]) {
                hasAlreadyClaimed = true;
            }
        }

        if (!hasAlreadyClaimed) {
            totalClaimed += 100;
            balances[msg.sender] += 100;
            claimers.push(msg.sender);
        } else {
            revert TokensClaimed();
        }
    }

    function createIssue(string memory _issueDesc, uint _quorum) external returns (uint) {
        if (address(msg.sender).balance == 0) {
            revert NoTokensHeld();
        }
        if (totalClaimed < _quorum) {
            revert QuorumToHigh(_quorum);
        }
        Issue storage newIssue = issues.push();
        newIssue.issueDesc = _issueDesc;
        newIssue.quorum = _quorum;
        numberOfIssues += 1;
        return numberOfIssues;
    }

    function getIssue(uint _id) external view returns (address[] memory,
        string memory,
        uint,
        uint,
        uint,
        uint,
        uint,
        bool,
        bool) {
        if (_id == 0) {
            revert("Invalid Id");
        }
        if (numberOfIssues < _id) {
            revert("Invalid Id");
        }   
        Issue storage issue = issues[_id-1];

        address[] memory arrayVoters = issue.voters.values();

        return (arrayVoters, issue.issueDesc, issue.votesFor, issue.votesAgainst, issue.votesAbstain, 
        issue.totalVotes, issue.quorum, issue.passed, issue.closed);
    }

    function vote(uint _issueId, Vote _vote) external {
        if (_issueId == 0) {
            revert("Invalid Id");
        }
        if (numberOfIssues < _issueId) {
            revert("Invalid Id");
        }   
        uint votes = balances[msg.sender];
        if (votes == 0) {
            revert NoTokensHeld();
        }
        Issue storage issue = issues[_issueId-1];
        if (issue.closed) {
            revert VotingClosed();
        }

        bool hasAlreadyVoted = false;
        for (uint i = 0; i < issue.voters.length(); i++) {
            if (msg.sender == issue.voters.at(i)) {
                hasAlreadyVoted = true;
            }
        }
        if (hasAlreadyVoted) {
            revert AlreadyVoted();
        }
        if (_vote == Vote.ABSTAIN) {
            issue.votesAbstain += votes;
        }
        if (_vote == Vote.AGAINST) {
            issue.votesAgainst += votes;
        }
        if (_vote == Vote.FOR) {
            issue.votesFor += votes;
        }
        if ((issue.votesFor + issue.votesAgainst + issue.votesAbstain) >= issue.quorum) {
            issue.closed = true;
            if (issue.votesFor > issue.votesAgainst) {
                issue.passed = true;
            }
        }

        balances[msg.sender] -= votes;

    }

}
