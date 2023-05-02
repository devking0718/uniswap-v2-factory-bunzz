// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

interface IUniswapV2Factory {
    /**
    * @param token0 token0 address
    * @param token1 token1 address
    * @param pair pair address
    * @dev create pair occur this event
    **/
    event PairCreated(address indexed token0, address indexed token1, address pair, uint256);

    /**
     * @param tokenA tokenA address
     * @param tokenB tokenB address
     * @return pair token address
     **/
    function createPair(address tokenA, address tokenB) external returns (address pair);

    /**
     * @dev set fee to address
     **/
    function setFeeTo(address) external;

    /**
     * @dev set setter address for setFeeTo
     *
     **/
    function setFeeToSetter(address) external;

    /**
     * @dev fee to address
     **/
    function feeTo() external view returns (address);

    /**
     * @dev setter address for feeTo
     **/
    function feeToSetter() external view returns (address);

    /**
     * @param tokenA tokenA address
     * @param tokenB tokenB address
     * @return pair address
     * @dev get pair address from tokenA and tokenB
     **/
    function getPair(address tokenA, address tokenB) external view returns (address pair);

    /**
     * @return pair address
     * @dev get pair address by index
     **/
    function allPairs(uint256) external view returns (address pair);

    /**
     * @dev get all pairs length
     **/
    function allPairsLength() external view returns (uint256);
}
