## (July 24, 2025)  
### DAY 39 — BLOCKCHAIN-DEV LEARNING LOG  
"Solidity"

---

### • Focus Areas  
Practice using modifiers for access control and contract state.  
Reinforce use of require(), msg.sender, msg.value.  
Track deposits with mappings and update core state variables.

---

### • Tools  
Remix IDE

---

### • Summary  
Built access_control.sol to manage ETH deposits with pause and withdrawal controls. Added onlyOwner and whenNotPaused modifiers to restrict functions. Used msg.sender to verify caller identity, msg.value to validate deposits, and mappings to track user balances.

Today`s contract: [access control](./access_control.sol)
