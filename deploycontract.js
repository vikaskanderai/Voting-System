var fs=require('fs');
var solc=require('solc');
var input = {
    language ="solidity",
    sources:{
    'vote.sol':fs.readFileSync('../try/vote.sol')
}
}
var output=solc.compile(input,1)
const bytecode = output.contracts['vote.sol:contract'].bytecode;
const abi = JSON.parse(output.contracts['vote.sol:contact'].interface);
var ethers=require('ethers');
var infuraAPI = '803bfc247d4f46e38646808284d3b9f6';
var provider = new ethers.providers.InfuraProvider(network='rinkeby',apiAccessToken=infuraAPI);
var privatekey ='7d66096a3433d6b3be3e83aa7e76e627751ee4e08d75f7d4541c16d0e1ca73b4';
var publicAddress ='0x032203cAEF3bE30186c0A7255A6EDD6302a4be90';
var wallet= new ethers.Wallet(privatekey,provider);

var deployTransaction = ethers.contract.getDeployTransaction("0x"+bytecode,abi, publicAddress)
deployTransaction.gaslimit =3080000;
wallet.sendTransaction(deployTransaction)