# Dynamic-NFT
This repo contains smart contracts of Dynamic Tracker NFT with Onchain Metadata.<br>
__The NFT interacts onchain with other contracts so as to send and receive data as per set by the holder of that NFT.__
Example uses can be:
- Tracking the price of an asset by interacting with oracle
- Tracking the user data in any DeFi protocol
- Tracking balance of a user related to any token
- ...
- ...
- ...
- Basically any data provided gasless by any protocol onchain can be catched inside this NFT :)


### Overview of the NFT Contract
The Holder can change the following two fields related to the NFT:
+ The name of the NFT so as to recognize it among others
+ The target contract address to interact with
+ The data to send to the target contract
+ Specifier of the return data type from target contract in the form of integer


### To-Do
- [x] Implement the Contract with onchain metadata
- [x] Reading the data as a general datatype and plug it into the NFT
- [ ] Make the specific example NFT contracts for monitoring the DeFi Protocols
- [ ] Deploying on mainnet

<br>
target : 0x87870Bca3F3fD6335C3F4ce8392D69350B4fA4E2 <br>
getUserAccountData(address user) => (uint256, uint256, uint256, uint256, uint256, uint256)
