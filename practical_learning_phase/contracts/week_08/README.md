# Week 08

Without writing much, this week is all about chainlink data feeds and how they work, this is what I did throughout this week on Cyfrin updraft:

## Chainlink Data Feeds: Summary

**Definition:**  
Chainlink Data Feeds provide secure, on-chain access to real-world data like asset prices, volatility, reserves, and L2 sequencer health.

### Types
- **Price Feeds:** Aggregated crypto/fiat asset prices.  
- **SmartData Feeds:** Tokenized real-world asset data.  
- **Rate and Volatility Feeds:** Interest rates, yield curves, volatility indexes.  
- **L2 Sequencer Uptime Feeds:** Track whether an L2 sequencer is up/down.  

### Components
- **Consumer Contract:** Your smart contract that fetches data using `AggregatorV3Interface`.  
- **Proxy Contract:** Points to the latest aggregator (upgrades without breaking consumer contracts).  
- **Aggregator Contract:** Collects, aggregates, and stores data from multiple Chainlink nodes.  

### Practical Use
- **Lending dApps (e.g, Aave):** Liquidation logic triggered using ETH/USD feed.  
- **Gaming:** Verifiable randomness for fairness.  
- **L2 dApps:** Pause withdrawals if sequencer goes offline.  

That will be all.