## (August 3, 2025)  
### DAY 49 — BLOCKCHAIN-DEV LEARNING LOG  
*Solidity*

---

### Tools  
Remix IDE

---

### Summary  
Created an `AutoRejector` contract that strictly allows only the `owner` to send ETH directly to the contract. All other direct payments are rejected and reverted using a custom error. Logged different Ether flows using events: accepted (owner), rejected (non-owner), deposit (using function), and withdrawals. This contract reinforced advanced control over ETH flow, `receive()` protection logic, `error` usage, and event-driven debugging.
Also, I learned a new thing, called custom errors. 

Today’s contract: [auto_rejector](./auto_rejector.sol)