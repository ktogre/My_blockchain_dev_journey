*Solidity*

---

### Tools  
Remix IDE

---

### Summary  
Built a `DonationTracker` smart contract that receives ETH from donors and records contributions using a mapping. Integrated `receive()` to handle direct ETH transfers and emit a `DonationsRecieved` event. Only the *owner* is allowed to withdraw all accumulated funds, triggering a `DonationsWithdrawn` event for traceability. Included access control via the `onlyOwner` modifier.

Today’s contract: [donation_tracker](./donation_tracker.sol)