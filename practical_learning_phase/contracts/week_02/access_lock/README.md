*Solidity*

---

### Tools  
Remix IDE

---

### Summary  
Created an `AccessLock` contract that allows the owner to lock or unlock access to a protected function. Used a `locked` boolean flag to control state and two custom modifiers: `onlyOwner` to restrict locking/unlocking actions, and `onlyWhenUnlocked` to prevent access to `doSomething()` when locked. Reinforced use of `require()` and `revert()` for clean access control and error handling.

Today’s contract: [access_lock](./access_lock.sol)