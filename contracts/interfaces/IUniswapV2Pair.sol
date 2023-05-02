// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

interface IUniswapV2Pair {
    /**
     * @param owner address owner
     * @param spender address spender
     * @param value amount to approve
     **/
    event Approval(address indexed owner, address indexed spender, uint256 value);
    /**
     * @param from adress from
     * @param to address to
     * @param value transfer amount
     **/
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @param sender address of sender
     * @param amount0 amount0
     * @param amount1 amount1
     **/
    event Mint(address indexed sender, uint256 amount0, uint256 amount1);

    /**
     * @param sender address of sender
     * @param amount0 amount0
     * @param amount1 amount1
     * @param to destination address
     **/
    event Burn(address indexed sender, uint256 amount0, uint256 amount1, address indexed to);

    /**
     * @param sender address of sender
     * @param amount0In input amount of token0
     * @param amount1In input amount of token1
     * @param amount0Out out amount of token0
     * @param amount1Out out amount of token1
     * @param to destination address
     **/
    event Swap(
        address indexed sender,
        uint256 amount0In,
        uint256 amount1In,
        uint256 amount0Out,
        uint256 amount1Out,
        address indexed to
    );

    /**
     * @param reserve0 reserve amount of token0
     * @param reserve1 reserve amount of token1
     **/
    event Sync(uint112 reserve0, uint112 reserve1);

    /**
     * @param spender address of spender
     * @param value approve amount
     **/
    function approve(address spender, uint256 value) external returns (bool);

    /**
     * @param to destination address
     * @param value transfer amount
     **/
    function transfer(address to, uint256 value) external returns (bool);

    /**
     * @param from sender address
     * @param to receiver address
     * @param value transfer amount
     **/
    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);

    /**
     * @param to destination address
     * @return liquidity liquidity amount
     **/
    function mint(address to) external returns (uint256 liquidity);

    /**
     * @param to destination address
     * @return amount0 token0 amount
     * @return amount1 token1 amount
     * */
    function burn(address to) external returns (uint256 amount0, uint256 amount1);

    /**
     * @param amount0Out out amount of token0
     * @param amount1Out out amount of token1
     * @param to destintion address
     * @param data bytes data
     **/
    function swap(
        uint256 amount0Out,
        uint256 amount1Out,
        address to,
        bytes calldata data
    ) external;

    /**
     * @param to address destination address
     **/
    function skim(address to) external;

    /**
     * @dev sync
     **/
    function sync() external;

    /**
     * @dev initializer
     **/
    function initialize(address, address) external;

    /**
     * @dev permit
     **/
    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    /**
     * @dev return totalSupply
     **/
    function totalSupply() external view returns (uint256);

    /**
     * @param owner address of owner
     * @dev get balance of owner
     **/
    function balanceOf(address owner) external view returns (uint256);

    /**
     * @param owner address of owner
     * @param spender address of spender
     * @dev get allowance amount
     **/
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev return factory
     **/
    function factory() external view returns (address);

    /**
     * @dev return token0
     **/
    function token0() external view returns (address);

    /**
     * @dev return token1
     **/
    function token1() external view returns (address);

    /**
     * @return reserve0 reserve amount of token0
     * @return reserve1 reserve amount of token1
     * @return blockTimestampLast last block timestamp
     * @dev get reserve info
     **/
    function getReserves()
        external
        view
        returns (
            uint112 reserve0,
            uint112 reserve1,
            uint32 blockTimestampLast
        );

    /**
     * @dev get last cumulative price of token0
     **/
    function price0CumulativeLast() external view returns (uint256);

    /**
     * @dev get last cumulative price of token
     **/
    function price1CumulativeLast() external view returns (uint256);

    /**
     * @dev return kLast
     **/
    function kLast() external view returns (uint256);

    /**
     * @dev return DOMAIN_SEPARATOR
     **/
    function DOMAIN_SEPARATOR() external view returns (bytes32);

    /**
     * @param owner address of owner
     * @dev return noce by owner
     **/
    function nonces(address owner) external view returns (uint256);

    /**
     * @dev return name
     **/
    function name() external pure returns (string memory);

    /**
     * @dev return symbol
     **/
    function symbol() external pure returns (string memory);

    /**
     * @dev return decimals
     **/
    function decimals() external pure returns (uint8);

    /**
     * @dev return PERMIT_TYPEHASH
     **/
    function PERMIT_TYPEHASH() external pure returns (bytes32);

    /**
     * @dev return MINIMUM_LIQUIDITY
     **/
    function MINIMUM_LIQUIDITY() external pure returns (uint256);
}
