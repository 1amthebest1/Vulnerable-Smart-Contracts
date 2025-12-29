
# Dust Entries Giving Everyone Money

1. The smart contract has a major issue, where the mathematical formula on line 34 can fail to give a share, or giving them less shares than they should get. ```sharesToMint = (msg.value * totalShares) / address(this).balance;```

2. This causes the contract balance to go up, without giving the buyer the share.

3. Attackers should see this bug, and buy the amount that gives them shares, ofcourse you wouldn't want to fall victim to this bug, as an attacker.

4. You basically chill, wait for ghost entries to happen, and then exit.

5. I found the contract misbehave on many points in remix, its mechanics for price of a share are sus too, I did not look much into that.

## Conclusion:
	
***Always test the maths you use, because solidity doesn't contain a real mechanism for decimal values, and your maths may not work as intended. Test the math part rigorously.*** 
