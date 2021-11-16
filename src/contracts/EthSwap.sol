pragma solidity ^0.5.0;

import "./Token.sol";

contract EthSwap {
    string public name = "EthSwap Instant Exchange";
    Token public token;
    uint public rate = 100;

    event TokensPurchased(
        address account,
        address token,
        uint amount,
        uint rate
    );

    event TokensSold(
        address account,
        address token,
        uint amount,
        uint rate
    );
    
    constructor(Token _token) public{
        token = _token;
    }

    function buyTokens() public payable{
        // Rdemption rate = # token for 1 ether
        // amount of ethr * redemption rate
        //msg palavra reservada global do solidity
        uint tokenAmount = msg.value * rate;
        
        //Verifica se tem tokens suficientes
        //require verifica se for verdade continua senao para a execução
        require(token.balanceOf(address(this))>=tokenAmount);

        //transfere os tokens
        token.transfer(msg.sender, tokenAmount);

        //emitir event
        emit TokensPurchased(msg.sender, address(token), tokenAmount, rate);
    }

    function sellTokens(uint _amount) public{
        //user tem que ter a quantidade
        require(token.balanceOf(msg.sender) >= _amount);

        //calcular a quantidade de ether
        uint etherAmount = _amount / rate;
        
        // ethswap tem ether suficiente
        require(address(this).balance >= etherAmount);

        // venda
        token.transferFrom(msg.sender, address(this), _amount);
        msg.sender.transfer(etherAmount);

       emit TokensSold(msg.sender, address(token), _amount, rate);
    }

}