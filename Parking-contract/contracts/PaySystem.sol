// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract PaySystem is Ownable, ERC1155 {

    string private name = "Unpaid Worker";
    string private symbol = "UW";
    uint256 private totalSupply = 1000000;
    uint256 private coinPrice;
    //默认设置为0
    // uint256 public constant tokenId = 0;

    //网站连接
    string private baseURI= "https://unpaidWorker.com/token/";

    // mapping(address => mapping(address => uint256)) allowed;

    constructor() ERC1155(baseURI) {
        _mint(msg.sender, 0, totalSupply, "");
        coinPrice = 0.1 ether;
    }

    modifier onlyUser() {
        require(msg.sender != owner(), "Only users can call this function");
        _;
    }

    modifier moneyGreaterThanZero(uint value) {
        require(value > 0, "Money must be greater than zero");
        _;
    }

    function mint(address account, uint256 id, uint256 amount) public onlyOwner {
        _mint(account, id, amount, "");
    }

    function burn(address account, uint256 id, uint256 amount) public onlyOwner {
        _burn(account, id, amount);
    }
    //id为0
    function getBalance(address account, uint256 id) public view onlyUser returns (uint256 balance) {
        balance = balanceOf(account, id);
    }
    function getCoinPrice() public view returns (uint256 price) {
        price = coinPrice;
    }

    function deposit(uint amount) public payable onlyUser moneyGreaterThanZero(amount) {
        require(balanceOf(owner(), 0) >= amount, "Insufficient balance of token");
        require(msg.value > 0, "Invalid amount");
        address payable ownerAddress = payable(owner());
        ownerAddress.transfer(msg.value);
        _safeTransferFrom(owner(), msg.sender, 0, amount, "");
    }

    function trade(address payTo, uint amount) public onlyUser moneyGreaterThanZero(amount) {
        require(payTo != msg.sender, "Cannot trade tokens to yourself");
        uint tokenBalance = getBalance(msg.sender, 0);
        require(tokenBalance >= amount, "Insufficient token balance");
        _safeTransferFrom(msg.sender, payTo, 0, amount, "");
    }


}

