## (July 22, 2025)  
### DAY 37 — BLOCKCHAIN-DEV LEARNING LOG  
**"Solidity"**

---

### • Focus Areas  
Control Logic and Function Visibility  
(require(), revert(), assert(), view, pure, payable, public, private, internal, external)

---

### • Tools  
Remix IDE

---

### • Summary

- require(): Used to validate inputs and conditions. Reverts if the condition fails.  
- revert(): Explicitly reverts execution with a custom error message.  
- assert(): Used to check for internal errors or invariants. Fails if a bug exists.  
- view: A read-only function. Cannot modify state variables.  
- pure: Cannot read or modify state variables. Used for logic-only functions.  
- payable: Allows a function to receive ETH.  
- public: Can be called from both inside and outside the contract.  
- private: Only accessible within the same contract.  
- internal: Accessible within the contract and derived (child) contracts.  
- external: Callable only from outside the contract (not internally).

---

### • Contract  
Check out the practice contract here: [Secure Wallet](./secure_wallet.sol)