pragma solidity 0.5.16;

contract MyDeFiProject {
   IUniswap uniswap;

   constructor(address _uniswap) public {
       uniswap = IUniswap(_uniswap); //initialisation of the Uniswap SC
   }

   // The function which allows the swap
    function swapTokensForEth(address token, uint amountIn, uint amountOutMin, uint deadline) external {
        IERC20(token).transferFrom(msg.sender, address(this), amountIn); //transfer of the tokens to the SC! You have "to approve" this transfer before the use of this function
        address[] memory path = new address[](2); //creation of the path
        path[0] = address(token); //initialisation of the path with the address of the token to swap
        path[1] = uniswap.WETH(); //initialisation of the path with the address of Uniswap WETH

        IERC20(token).approve(address(uniswap), amountIn); //authorise uniswap to use our tokens

        uniswap.swapExactTokensForEth(
            amountIn,
            amountOutMin,
            path,
            msg.sender,
            deadline
    ); //make the swap, ETH will be transferred directly to the msg.sender

  }

}
