//TO LAUNCH THE CODE: NODE app.js

//Answer : node app.js: 38.630189045042991864 ETH

const Web3 = require("web3");
const web3 = new Web3(new Web3.providers.
    HttpProvider("https://mainnet.infura.io/v3/df38882d8ddf470c8dc5f7eaf2250a46"));

web3.eth.getBalance("0x5A0b54D5dc17e0AadC383d2db43B0a0D3E029c4c", function(err, result){
    if (err) console.log(err);
    else console.log(web3.utils.fromWei(result, "ether") + " ETH")
});