# NFT_CONTRACT-1

address NFT : https://sepolia.etherscan.io/address/0xcee2561869dbcb929e521284d2bf166d67818ffd#writeContract


address ERC20 : https://sepolia.etherscan.io/address/0x52537989d0bba01f7f18f0ff4a410cb7bde37d41#writeContract

## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

- **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
- **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
- **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
- **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```

# foundrytemplate

### Deployment commands

```shell
$ forge build
```

- load env using

```shell
$ source .env //on root folder env location
```

- //simulation to check if all things are correct

```shell
$ forge script script/NFT.s.sol:NFTScript
```

- //simulation to check if all things are correct

```shell
$ forge script script/NFT.s.sol:NFTScript --rpc-url $SEPOLIAAPIKEY
```

-- for deployment on chain and verification

```shell
 forge script script/NFT.s.sol:NFTScript --rpc-url $SEPOLIAAPIKEY --broadcast --verify -vvvv --sender 0xbe07B7EEF81DcB04cC9E03c073ef93CBcD52b226 --private-key $DEV_PRIVATE_KEY
```

