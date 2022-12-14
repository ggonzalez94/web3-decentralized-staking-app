# ๐ฉ Challenge 1: ๐ฅฉ Decentralized Staking App
> This is a project based on [Speed Run Ethereum Challenges](https://speedrunethereum.com/) and uses [Scaffold-Eth](https://github.com/scaffold-eth/scaffold-eth) for the structure of the project.

## What does it do?
> ๐ฆธ A superpower of Ethereum is allowing you, the builder, to create a simple set of rules that an adversarial group of players can use to work together. In this challenge, you create a decentralized application where users can coordinate a group funding effort. If the users cooperate, the money is collected in a second smart contract. If they defect, the worst that can happen is everyone gets their money back. The users only have to trust the code.

## ๐  Quick Start - Deploy to local network
    This steps allow you to deploy to a local hardhat network.  

> Clone the repo  
``` bash 
git clone https://github.com/ggonzalez94/web3-decentralized-staking-app.git
```

> Install packages
``` bash 
yarn install
```

> Run the projects and deploy the Smart Contracts
```bash
yarn start   (react app frontend)
yarn chain   (hardhat backend)
yarn deploy  (to compile, deploy, and publish your contracts to the frontend)
```
---
> ๐ป View your frontend at http://localhost:3000/  
---
> ๐ฉโ๐ป Rerun `yarn deploy --reset` whenever you want to deploy new contracts to the frontend.
---
#### ๐งช Test it!
``` bash 
yarn test
```

## ๐ Deploy to live network
If you want to deploy to a live network such as rinkeby you can follow these steps:  

๐ก Edit the `defaultNetwork` to [your choice of public EVM networks](https://ethereum.org/en/developers/docs/networks/) in `packages/hardhat/hardhat.config.js`

๐ฉโ๐ You will want to run `yarn account` to see if you have a **deployer address**

๐ If you don't have one, run `yarn generate` to create a mnemonic and save it locally for deploying.

โฝ๏ธ You will need to send ETH to your **deployer address** with your wallet.

 >  ๐ Run `yarn deploy` to deploy your smart contract to a public network (selected in hardhat.config.js)
---