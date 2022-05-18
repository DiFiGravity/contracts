//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import { 
    ISuperfluid 
} from "@superfluid-finance/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol"; //"@superfluid-finance/ethereum-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol";

import { 
    IConstantFlowAgreementV1 
} from "@superfluid-finance/ethereum-contracts/contracts/interfaces/agreements/IConstantFlowAgreementV1.sol";

import {
    CFAv1Library
} from "@superfluid-finance/ethereum-contracts/contracts/apps/CFAv1Library.sol";

contract Greeter {

    struct LimitRangeOrder {
        int upperLimit;
        int lowerLimit;
        int96 streamRate; // hourly rate
    }

    // mapping of user address to (mapping of token address to order)
    mapping (address=> mapping (address=>LimitRangeOrder)) addressToOrder;
    
    // position of the token in the supported tokens array
    mapping (address=> uint256) addressToToken;

    // mapping of token address to Ricochet contract address
    mapping (address=> address) tokenToRicochet;

    // To check the token price
    // Mapping of token address to token price feed from chainlink
    mapping (address=> address1) tokenToPriceFeed;
    
    // supported tokens
    address[] tokens;

    constructor() public {
        tokens.push(address(0));
    }

    // TODO type of token should be iSuperFluidToken, import that interface
    function createNewOrder(address _token, uint256 _upperLimit, uint256 _lowerLimit, int96 _streamRate) public {
        require(_token != address(0), "Token address cannot be 0");
        require(_upperLimit > _lowerLimit, "Upper limit must be greater than lower limit");
        require(_streamRate > 0);
        require(addressToOrder[msg.sender][_token].upperLimit == 0);
        require(addressToOrder[msg.sender][_token].lowerLimit == 0);
        require(addressToOrder[msg.sender][_token].streamRate == 0);
        addressToOrder[msg.sender][_token].upperLimit = _upperLimit;
        addressToOrder[msg.sender][_token].lowerLimit = _lowerLimit;
        addressToOrder[msg.sender][_token].streamRate = _streamRate;
    }

    // use cfav1.getFlow to get current flow from user for this token
    // in case cfav1 doesnt have getFlow then google or discord

    // if this flow is greater than zero then check if token price is in limit range or not and decide to open/close the stream
    // if flow is zero then check price and start stream

    // function to start/stop stream
    function toggleStream(address _user, address _token) public {
        
    }




    // TODO Create functions for adding and removing tokens


}
