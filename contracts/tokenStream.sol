//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

// import { 
//     ISuperfluid 
// } from "@superfluid-finance/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol"; //"@superfluid-finance/ethereum-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol";

import {
    ISuperfluid,
    ISuperToken,
    ISuperApp,
    ISuperAgreement,
    ContextDefinitions,
    SuperAppDefinitions
} from "@superfluid-finance/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol";

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
    mapping (address=> address) tokenToPriceFeed;
    
    // supported tokens - USDCx, MATICx, WBTCx, DAIx
    address[] tokens = [0xCAa7349CEA390F89641fe306D93591f87595dc1F, 0x3aD736904E9e65189c3000c7DD2c8AC8bB7cD4e3, 0x4086eBf75233e8492F1BCDa41C7f2A8288c2fB92, 0x1305F6B6Df9Dc47159D12Eb7aC2804d4A33173c2];

    constructor() {
        // tokens.push(address(0));
        addressToToken[tokens[0]] = 0;
        addressToToken[tokens[1]] = 1;
        addressToToken[tokens[2]] = 2;
        addressToToken[tokens[3]] = 3;

        tokenToPriceFeed[tokens[0]] = 0xfE4A8cc5b5B2366C1B58Bea3858e81843581b2F7; // USDC - USD
        tokenToPriceFeed[tokens[1]] = 0xAB594600376Ec9fD91F8e885dADF0CE036862dE0; // MATIC - USD
        tokenToPriceFeed[tokens[2]] = 0xDE31F8bFBD8c84b5360CFACCa3539B938dd78ae6; // WBTC - USD
        tokenToPriceFeed[tokens[3]] = 0x4746DeC9e833A82EC7C2C1356372CcF2cfcD2F3D; // DAI - USD
    }

    // TODO type of token should be iSuperFluidToken, import that interface
    function createNewOrder(ISuperToken _token, int256 _upperLimit, int256 _lowerLimit, int96 _streamRate) public {
        require(address(_token) != address(0), "Token address cannot be 0");
        require(_upperLimit > _lowerLimit, "Upper limit must be greater than lower limit");
        require(_streamRate > 0, "Stream rate must be greater than zero");
        require(addressToOrder[msg.sender][address(_token)].upperLimit == 0);
        require(addressToOrder[msg.sender][address(_token)].lowerLimit == 0);
        require(addressToOrder[msg.sender][address(_token)].streamRate == 0);
        addressToOrder[msg.sender][address(_token)].upperLimit = _upperLimit;
        addressToOrder[msg.sender][address(_token)].lowerLimit = _lowerLimit;
        addressToOrder[msg.sender][address(_token)].streamRate = _streamRate;
    }

    // use cfav1.getFlow to get current flow from user for this token
    // in case cfav1 doesnt have getFlow then google or discord

    // if this flow is greater than zero then check if token price is in limit range or not and decide to open/close the stream
    // if flow is zero then check price and start stream

    function checkTokenPrice(address _token) public {

    }

    // function to start/stop stream
    function toggleStream(address _user, address _token) public {
        
    }




    // TODO Create functions for adding and removing tokens


}
