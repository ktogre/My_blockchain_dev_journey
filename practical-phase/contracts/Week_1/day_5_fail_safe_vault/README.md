## (July 25, 2025)  
### DAY 40 — BLOCKCHAIN-DEV LEARNING LOG  
"Solidity"

---

### • Focus Areas  
Practice fail-safe mechanisms using receive() and fallback() behavior and how to react to unexpected or high-value ETH transfers.

---

### • Tools  
Remix IDE

---

### • Summary  
A guarded ETH vault with blacklist controls, deposit and withdraw tracking, and a built-in emergency pause. Used receive() to revert large transfers, and fallback() to block unknown function calls.

Today`s contract: [fail safe vault](./fail_safe_vault.sol)
