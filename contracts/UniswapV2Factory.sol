// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import './interfaces/IUniswapV2Factory.sol';
import './UniswapV2Pair.sol';

contract UniswapV2Factory is IUniswapV2Factory {
    /**
     * @dev fee address
     **/
    address public feeTo;

    /**
     * @dev setter address of fee
     * */
    address public feeToSetter;

    /**
     * @dev get pair
     **/
    mapping(address => mapping(address => address)) public getPair;

    /**
     * @dev pairs list
     **/
    address[] public allPairs;

    bool internal locked;

    modifier noReentrant() {
        require(!locked, 'No re-entrancy');
        locked = true;
        _;
        locked = false;
    }

    /**
     * @param _feeToSetter setter address for fee
     **/
    constructor(address _feeToSetter) {
        require(_feeToSetter != address(0), 'UniswapV2: _feeToSetter should not be the zero address');
        feeToSetter = _feeToSetter;
    }

    /**
     * @param tokenA address of tokenA
     * @param tokenB address of tokenB
     * @return pair address of pair
     **/
    function createPair(address tokenA, address tokenB) external noReentrant returns (address pair) {
        require(tokenA != tokenB, 'UniswapV2: IDENTICAL_ADDRESSES');
        (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        require(token0 != address(0), 'UniswapV2: ZERO_ADDRESS');
        require(getPair[token0][token1] == address(0), 'UniswapV2: PAIR_EXISTS'); // single check is sufficient
        bytes memory bytecode = type(UniswapV2Pair).creationCode;
        bytes32 salt = keccak256(abi.encodePacked(token0, token1));
        assembly {
            pair := create2(0, add(bytecode, 32), mload(bytecode), salt)
        }
        IUniswapV2Pair(pair).initialize(token0, token1);
        getPair[token0][token1] = pair;
        getPair[token1][token0] = pair; // populate mapping in the reverse direction
        allPairs.push(pair);
        emit PairCreated(token0, token1, pair, allPairs.length);
    }

    /**
     * @param _feeTo address of fee
     * */
    function setFeeTo(address _feeTo) external {
        require(msg.sender == feeToSetter, 'UniswapV2: FORBIDDEN');
        feeTo = _feeTo;
    }

    /**
     * @param _feeToSetter setter address for fee
     **/
    function setFeeToSetter(address _feeToSetter) external {
        require(msg.sender == feeToSetter, 'UniswapV2: FORBIDDEN');
        feeToSetter = _feeToSetter;
    }

    /**
     * @dev get all pairs length
     **/
    function allPairsLength() external view returns (uint256) {
        return allPairs.length;
    }
}
