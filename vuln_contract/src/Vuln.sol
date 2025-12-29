// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/*
    Simple ETH vault with share accounting.
    Users deposit ETH and receive shares.
    Shares represent a proportional claim on the vault.
*/

contract EtherVault {
    mapping(address => uint256) public shares;
    uint256 public totalShares;

    receive() external payable {}

    function getShares(address addressToSee) public view returns(uint){
	return(shares[addressToSee]);
    }

    function balance() public view returns(uint){
		
		return address(this).balance;
	
	}

    function deposit() external payable {
        require(msg.value > 0, "zero deposit");

        uint256 sharesToMint;

        if (totalShares == 0) {
            sharesToMint = msg.value;
        } else {
            sharesToMint = (msg.value * totalShares) / address(this).balance;
        }

        shares[msg.sender] += sharesToMint;
        totalShares += sharesToMint;
    }

    function withdraw(uint256 shareAmount) external {
        require(shares[msg.sender] >= shareAmount, "not enough shares");

        uint256 ethAmount = (shareAmount * address(this).balance) / totalShares;

        shares[msg.sender] -= shareAmount;
        totalShares -= shareAmount;

        (bool ok, ) = msg.sender.call{value: ethAmount}("");
        require(ok, "eth transfer failed");
    }

    function pricePerShare() external view returns (uint256) {
        if (totalShares == 0) return 0;
        return address(this).balance / totalShares;
    }
}
