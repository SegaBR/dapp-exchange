require('babel-register');
require('babel-polyfill');

module.exports = {
  //connect to ganache network bc
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*" // Match any network id
    },
  },
  contracts_directory: './src/contracts/',
  contracts_build_directory: './src/abis/',
  //compile de smart contracts
  compilers: {
    solc: {
      optimizer: {
        enabled: true,
        runs: 200
      },
      //nao precisa dessa linha mas deixa ae
      evmVersion:"petersburg"
    }
  }
}
