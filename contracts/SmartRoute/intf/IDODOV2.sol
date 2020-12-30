/*

    Copyright 2020 DODO ZOO.
    SPDX-License-Identifier: Apache-2.0

*/

pragma solidity 0.6.9;
pragma experimental ABIEncoderV2;

interface IDODOV2 {

    //========== Common ==================

    function sellBase(address to) external returns (uint256 receiveQuoteAmount);

    function sellQuote(address to) external returns (uint256 receiveBaseAmount);

    function getVaultReserve() external view returns (uint256 baseReserve, uint256 quoteReserve);

    function _BASE_TOKEN_() external view returns (address);

    function _QUOTE_TOKEN_() external view returns (address);

    function _BUYING_CLOSE_() external view returns (bool);

    function _SELLING_CLOSE_() external view returns (bool);

    function _OWNER_() external returns (address);

    function getPMMStateForCall() external view returns (
            uint256 i,
            uint256 K,
            uint256 B,
            uint256 Q,
            uint256 B0,
            uint256 Q0,
            uint8 R
    );

    function getUserFeeRate(address user) external view returns (uint256 lpFeeRate, uint256 mtFeeRate);

    //========== DODOVendingMachine ========
    
    function createDODOVendingMachine(
        address baseToken,
        address quoteToken,
        uint256 lpFeeRate,
        uint256 i,
        uint256 k
    ) external returns (address newVendingMachine);
    
    function buyShares(address to) external returns (uint256,uint256,uint256);

    function getVendingMachineBidirection(address token0, address token1) external view returns (address[] memory baseToken0Machines, address[] memory baseToken1Machines);

    //========== DODOPrivatePool ===========

    function createDODOPrivatePool() external returns (address newPrivatePool);

    function initDODOPrivatePool(
        address dppAddress,
        address creator,
        address baseToken,
        address quoteToken,
        uint256 lpFeeRate,
        uint256 mtFeeRate,
        uint256 k,
        uint256 i
    ) external;

    function reset(
        address operator,
        uint256 newLpFeeRate,
        uint256 newMtFeeRate,
        uint256 newI,
        uint256 newK,
        uint256 baseOutAmount,
        uint256 quoteOutAmount,
        uint256 minBaseReserve,
        uint256 minQuoteReserve
    ) external returns (bool); 

    function getPrivatePoolBidirection(address token0, address token1) external view returns (address[] memory baseToken0Pool, address[] memory baseToken1Pool);
    
    //========== CrowdPooling ===========

    function createCrowdPooling() external returns (address newCrowdPooling);

    function initCrowdPooling(
        address cpAddress,
        address creator,
        address baseToken,
        address quoteToken,
        uint256[] memory timeLine,
        uint256[] memory valueList
    ) external;

    function bid(address to) external;
}