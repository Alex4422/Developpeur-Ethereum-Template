pragma solidity 0.8.9;

contract PullPayment {

    //key elements of this pattern and stores the amount of ether (in wei) that each address is
    //allowed to withdraw.
    mapping(address => uint256) public payments;
    uint256 public totalPayments;

    /**
        @dev Called by the payer to store the sent amount as credit to be pulled
        @param dest The destination address of the funds
        @param amount The amount to transfer
    */
    function allowForPull(address payable dest, uint256 amount) internal {

        payments[dest] = payments[dest] + amount;
        totalPayments = totalPayments + amount;
    }

    /**
        @dev withdraw accumulated balance called by payee
    */
    function withdraw() public {

        require(payments[msg.sender] != 0);
        require(address(this).balance >= payments[msg.sender]);
        totalPayments = totalPayments - payments[msg.sender];

        //to be conform with the checks Effects Interactions pattern & avoid re-entrancy
        payments[msg.sender] = 0;

        payable(msg.sender).transfer(payments[msg.sender]);
    }
}
