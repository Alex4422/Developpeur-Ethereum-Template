// La valeur de la variable data est 30.

const Web3 = require('web3');

const rpcURL = "https://ropsten.infura.io/v3/df38882d8ddf470c8dc5f7eaf2250a46";

const web3 = new Web3(rpcURL);

const ABI = [
    {
        "inputs": [],
        "name": "get",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "x",
                "type": "uint256"
            }
        ],
        "name": "set",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    }
];

//Deploy the SC on the @ asked
const address = "0x8cD906ff391b25304E0572b92028bE24eC1eABFb";

const simpleStorage = new web3.eth.Contract(ABI,address);

simpleStorage.methods.get().call((err, data) => {
    console.log(data);
});