# Uniswap V2 Factory

## Overview

Uniswap Factory allows you to create uniswap liquidity pair contracts and you can fetch the pair address of any ERC20 token that has an active pair.

## How to use

- The factory holds the generic bytecode responsible for powering pairs. Its primary job is to create one and only one smart contract per unique token pair. It also contains logic to turn on the protocol charge.

- Pairs have two primary purposes: serving as automated market makers and keeping track of pool token balances. They also expose data which can be used to build decentralized price oracles.

## Events

`PairCreated`
Emitted each time a pair is created via [createPair](#write).

- Params

| name   | type    | description              |
| :----- | :------ | :----------------------- |
| token0 | address | The address of token0    |
| token1 | address | The address of token1    |
|        | uint    | The final uint log value |

- token0 is guaranteed to be strictly less than token1 by sort order.

- The final uint log value will be 1 for the first pair created, 2 for the second, etc.

## Functions

### WRITE Functions

`createPair`

Creates a pair for tokenA and tokenB if one doesn't exist already.

- Event

  Emits [PairCreated](#events)

- Params

  | name   | type    | description            |
  | :----- | :------ | :--------------------- |
  | tokenA | address | The address of token A |
  | tokenB | address | The address of token B |

`setFeeTo`

Set fee address by setter.

- Params

  | name    | type    | description        |
  | :------ | :------ | :----------------- |
  | \_feeTo | address | The address of fee |

`setFeeToSetter`

Set a new setter address by **older setter**.

- Params

  | name          | type    | description                 |
  | :------------ | :------ | :-------------------------- |
  | \_feeToSetter | address | The address of a new setter |

### Read Functions

`feeTo`

Get address to which commission fee is sent.

`feeToSetter`

The address allowed to change [feeTo](#read)

`getPair`

Returns the address of the pair for tokenA and tokenB, if it has been created, else address(0)

`allPairs`

Returns the address of the nth pair (0-indexed) created through the factory, or address(0) (0x0000000000000000000000000000000000000000) if not enough pairs have been created yet.

- Pass 0 for the address of the first pair created, 1 for the second, etc.

# Uniswap V2 Pair

## Events

`Mint`

Emitted each time liquidity tokens are created via mint

- Params

| name    | type    | description                |
| :------ | :------ | :------------------------- |
| sender  | address | The address of mint client |
| amount0 | uint    | The amount of token0       |
| amount1 | uint    | The amount of token1       |

`Burn`

Emitted each time liquidity tokens are destroyed via burn

- Params

| name    | type    | description                |
| :------ | :------ | :------------------------- |
| sender  | address | The address of mint client |
| amount0 | uint    | The amount of token0       |
| amount1 | uint    | The amount of token1       |
| to      | address | The destination address    |

`Swap`

Emitted each time liquidity tokens are destroyed via burn

- Params

| name       | type    | description                 |
| :--------- | :------ | :-------------------------- |
| sender     | address | The address of mint client  |
| amount0In  | uint    | The input amount of token0  |
| amount1In  | uint    | The input amount of token1  |
| amount0Out | uint    | The output amount of token0 |
| amount1Out | uint    | The output amount of token1 |
| to         | address | The destination address     |

`Sync`

Emitted each time reserves are updated via `mint`, `burn`, `swap`, or `sync`

- Params

| name     | type    | description                  |
| :------- | :------ | :--------------------------- |
| reserve0 | uint112 | The token0 amount to reserve |
| reserve1 | uint112 | The token1 amount to reserve |

## Functions

### Read Functions

`MINIMUM_LIQUIDITY`

Returns 1000 for all pairs. See Minimum Liquidity.

`factory`

Returns the factory address.

`token0`

Returns the address of the pair token with the lower sort order.

`token1`

Returns the address of the pair token with the higher sort order.

`getReserves`

Returns the reserves of token0 and token1 used to price trades and distribute liquidity. Also returns the block.timestamp (mod 2\*\*32) of the last block during which an interaction occured for the pair.

`price0CumulativeLast`

`price1CumulativeLast`

`kLast`

Returns the product of the reserves as of the most recent liquidity event.

### Write Functions

`mint`

Creates pool tokens.

- Emits `Mint`, `Sync`, `Transfer`

| name    | type | description    |
| :------ | :--- | :------------- |
| address | to   | minted address |

`swap`

Swaps tokens. For regular swaps, data.length must be 0.

- Emits `Swap`, `Sync`

| name    | type       | description              |
| :------ | :--------- | :----------------------- |
| uint    | amount0Out | The output token0 amount |
| uint    | amount1Out | The output token1 amount |
| address | to         | Destination address      |
| bytes   | data       | bytes data               |

`skim`

Functions as a recovery mechanism in case enough tokens are sent to an pair to
overflow the two uint112 storage slots for reserves, which could otherwise cause trades to fail.

| name    | type | description |
| :------ | :--- | :---------- |
| address | to   | To address  |

`sync`

Functions as a recovery mechanism in the case that a token asynchronously
deflates the balance of a pair. In this case, trades will receive sub-optimal rates, and if no liquidity provider is willing to rectify the situation, the pair is stuck.

# Local Development

The following assumes the use of `node@>=10`.

## Install Dependencies

`yarn`

## Compile Contracts

`yarn compile`

## Run Tests

`yarn test`
