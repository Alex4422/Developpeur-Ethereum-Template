pragma solidity 0.8.9;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';


contract Dai is ERC20{

    constructor() public ERC20('Dai Stablecoin', 'DAI'){

    }

    //faucet function to create Dai token
    function faucet(address recipient, uint amount) external{
        _mint(recipient, amount);
    }

}
