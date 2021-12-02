pragma solidity 0.8.9;

import '@openzeppelin/contracts/token/ERC20/IERC20.sol';

contract MyDeFiProject {

    IERC20 dai;

    constructor(address daiAddress) public {
        //inject the @ of dai token to use
        dai = IERC20(daiAddress);
    }

    //function which allows to make a transfer of Dai to the recipient
    function foo(address recipient, uint amount) external {
        //instructions
        dai.transfer(recipient, amount);
    }
}
