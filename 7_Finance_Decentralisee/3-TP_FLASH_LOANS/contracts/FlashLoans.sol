pragma solidity 0.5.16;

import 'https://github.com/aave/flashloan-box/blob/Remix/contracts/aave/FlashLoanReceiverBase.sol';
import 'https://github.com/aave/flashloan-box/blob/Remix/contracts/aave/ILendingPoolAddressesProvider.sol';
import 'https://github.com/aave/flashloan-box/blob/Remix/contracts/aave/ILendingPool.sol';

contract FlashLoans is FlashLoanReceiverBase{

    ILendingPoolAddressesProvider provider;
    address dai;

    constructor(
        address _provider,
        address _dai)
        FlashLoanReceiverBase(_provider)
        public {
        provider = ILendingPoolAddressesProvider(_provider);
        dai = _dai;
    }

    function flashLoan(uint amount, bytes calldata _params) external {

        //get a pool of loans
        IlendingPool lendingPool = IlendingPool(provider.getLendingPool());

        // Init. of the flash loan, specifying the SC which will receive the loan: address(this)
        // the address of the token which you want to borrow & the amount(dai)
        // amount to borrow
        lendingPool.flashLoan(address(this), dai, amount, _params);
    }


    function executeOperation(address _reserve, uint _amount, uint _fee, bytes memory _params)  /*override*/ external {

            require(_amount <= getBalanceInternal(address(this), _reserve), "Invalid balance, was the flashLoan successful?");

            //logic code! You can do: arbitrage, refinance loan, change collateral of loan

            uint totalDebt = _amount.add(_fee);

            //refund of the flashLoan
            transferFundsBackToPoolInternal(_reserve, totalDebt);
        }



















}

