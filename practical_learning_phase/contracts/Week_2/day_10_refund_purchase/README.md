## (July 30, 2025)  
### DAY 45 — BLOCKCHAIN-DEV LEARNING LOG  
*Solidity*

---

### Tools  
Remix IDE

---

### Summary  
Developed a `RefundablePurchase` smart contract where the buyer pays a fixed `price` to the seller. Purchase is tracked using a `purchased` flag, and only the *seller* can initiate a refund to the buyer or withdraw the funds if the transaction is final.

Today’s contract: [refund_purchase](./refund_purchase.sol)