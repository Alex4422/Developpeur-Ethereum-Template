const { ChainId, Fetcher, WETH, Route, Trade, TokenAmount, TradeType, Percent} = require('@uniswap/sdk');
const ethers = require('ethers');

const chainId = ChainId.MAINNET;
const tokenAddress = '0x6B175474E89094C44Da98b954EedeAC495271d0F';
// DAI address mainnet
// Where I can find this address, I don't understand

const init = async() => {
    const dai = await Fetcher.fetchTokenData(chainId, tokenAddress);
    const weth = WETH[chainId];
    const pair = await  Fetcher.fetchPairData(dai, weth);
    const route = new Route([pair], weth);


    console.log(route.midPrice.toSignificant(6)); // combien de DAI pour 1 WETH
    console.log(route.midPrice.invert().toSignificant(6)); // le prix inversé
    
    const trade = new Trade(route, new TokenAmount(weth,'100000000000000000'), TradeType.EXACT_INPUT);


    console.log(trade.executionPrice.toSignificant(6));
    console.log(trade.nextMidPrice.toSignificant(6));

    const slippageTolerance = new Percent('50', '10000'); // tolérance prix 50 bips = 0,050%

    const amountOutMin = trade.minimumAmountOut(slippageTolerance).raw //minimum des tokens à récupérer avec une tolérance de 0.050%
    const path = [weth.address, dai.address]; //les tokens à échanger
    const to = '';
    const deadline = Math.floor(Date.now() / 1000) + 60; // le délai après lequel le trade n'est plus valable
    const value = trade.inputAmount.raw //la valeur des éthers à envoyer

    const provider = ethers.getDefaultProvider('mainnet', {
        infura:'https://mainnet.infura.io/v3/df38882d8ddf470c8dc5f7eaf2250a46'
    }); //utilisation du provider infura pour effectuer 1 transaction

    const signer = new ethers.Wallet(PRIVATE_KEY); //get your wallet thanks to the private key

    const account = signer.connect(provider); //get the account which makes the transaction

    const uniswap = new ethers.Contract(
        '0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D',
        ['function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline) external payable returns (uint[] memory amounts)'],
        account
    ); // get the SC of uniswap with the @ of SC and the ABI. Thanks to the ethers, we can pass the function to use in solidity

    const tx = await uniswap.swapExactETHForTokens(

        amountOutMin,
        path,
        to,
        deadline,
        { value, gasPrice: 20e9}
    ); //envoyer la tx with the good parameters

    console.log('tx hash:', ${tx.hash}) //displays the hash of the transaction

    const receipt = await tx.wait(); //get the tx receipt
    console.log('Tx was mined in block', ${receipt.blockNumber});
}

init();
