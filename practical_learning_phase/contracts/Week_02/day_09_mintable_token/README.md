## (July 29, 2025)  
### DAY 44 — BLOCKCHAIN-DEV LEARNING LOG  
*Solidity*

---

### Focus Areas  
Implemented a mintable token contract with `mint()` and `burn()` mechanics, while reinforcing ERC-20 allowance logic. Practiced supply control using `totalSupply` and `maxSupply` limits, ownership-restricted minting, and standard event emissions for state changes.

---

### Tools  
Remix IDE

---

### Summary  
Built a `mintable_token` contract allowing the owner to mint tokens up to a capped `maxSupply`. Integrated delegated token transfer using `approve()` and `transferFrom()`, and added token destruction through `burn()` by any holder.

Today’s contract: [mintable_token](./mintable_token.sol)