# Introduction

## Tips

### Autosave

Use a setting hat autosave your file.
To do it : 

1) CTRL+Maj+P
2) type "settings"
3) Select _Preferences : Open User settings (JSON)_
4) In the file, for the entry _files.autoSave_, set _afterDelay_

### Import not working in VS Code

In some contracts, import do not work.
For instance 

```solidity
import "forge-std/Test.sol";
```

is not working in a Test SC and VS code warns a error message.
To fix it, in the settings file (Cf above), add the following setting : 

```
"solidity.packageDefaultDependenciesDirectory": ["node_modules", "lib"]
```

Usually, only _node_modules_ are present. Add _lib_.
Then, re-launch VS Code


## Prerequisite 

### Install libraries

```sh
forge install smartcontractkit/chainlink-brownie-contracts
```

You will probably remapping the alias of the import.
For instance : 

```solidity
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
```

is not working, so you must tell VSCode that _@chainlink_ is mapped with _lib/chainlink-brownie-contracts_

To do this, run the following command : 


```sh
forge remappings > remappings.txt
```

This will create a _remappings.txt_ file at root directory.
Just modify the file to do a correct mapping.
For instance : 

```
@chainlink/=lib/chainlink-brownie-contracts/
```

Anotehr way is to update the _foundry.toml_ file and add the following line : 

```
remappings = ["@chainlink/contracts/=lib/chainlink-brownie-contracts/contracts"]
```

Then re-launch VSCode

# Compile SC

To compile our SC : 

```sh
forge compile
```

It will create our compiled SC in the _out_ directory


# Tests

## Naming conventions

All test files must be in the _test_ directory and be named with _.t_ before the _.sol_ extension

## Launch tests

Simply run : 

```sh
forge test
```

If we wante to use our log with _console.log_, run : 

```sh
forge test -vv
```
(With more 'v' in the options, you have more verbosity. Ex : with 4 'v', you will have stack trace)
###  Remarks

When we launch tests with _forge test_, the SC is not really deployed in a real blockchain, we can have errors by manipulating function of this SC.
We must add a RPC_URL to deploy implictely the SC on the BC.

### By Providing a RPC_URL

```sh
forge test -vvvv --fork-url $SEPOLIA_RPC_URL
```

Ensure that your env variables are persisted in your bash settings with the command : 

```sh
source .env
```

## Coverage 

```sh
forge coverage --fork-url $SEPOLIA_RPC_URL
```


# Lesson #1

We just deploy and test some functions for our _funMe_ smart contract

All tests of lesson #1 are their function named with _test1XXX_.
To test only these functions, run : 

```sh
forge test --match-test test1.* -vv --fork-url $SEPOLIA_RPC_URL
```


# Lesson #2

## Exercice 1
We want to make our code more modular. 
The address of price feed on Sepolia Network is hard-coded (0x694AA1769357215DE4FAC081bf1f309aDC325306) 
and write many times in the implementation.
We want to dynamically assign it during deployment phase of the smart contract.
Solution : So we must pass the address price feed in the constructor

## Exercice 2
When the implemnation of the constructor is changing, we must change either : 
 - the deployment script (Ex : _new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);_)
 - the function _setUp_ in the test script (same)

Solution : 
We can factorize it by making the _run_ function of the deployment script a function that returns the smart contract.<br>
Then, in the _setUp_ function of the test script, we wan call the _run_ function of the deployment script

Run : 

```sh
forge test --match-test test1.* -vv --fork-url $SEPOLIA_RPC_URL
```















