## (August 2, 2025)  
### DAY 48 — BLOCKCHAIN-DEV LEARNING LOG  
*Solidity*

---

### Tools  
Remix IDE

---

### Summary  
Built a `ChangeContractName` contract that allows the owner to reset the contract's name. Implemented event logging for name changes, Ether reception (`receive()`), and fallback calls (`fallback()`). Reinforced the use of `onlyOwner` modifier and best practices for emitting events to track important state changes and unexpected interactions.

Today’s contract: [change_contract_name](./change_contract_name.sol)