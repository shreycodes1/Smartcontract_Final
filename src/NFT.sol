// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract NFT is ERC721URIStorageUpgradeable, OwnableUpgradeable {
    uint256 public _tokenIds; // Tracking the no of tokens minted
    address public tokenAddress;
    mapping(uint256 => bool) public listedNFT;
    mapping(uint256 => uint256) public priceofNFT;

    event NFTListed(address indexed seller, uint256 indexed tokenId, uint256 price, string tokenUri);
    event NFTBought(address indexed seller, address indexed buyer, uint256 indexed tokenId, string tokenUri, uint256 price);
    event NFTCreated(address indexed creator, string tokenUri, uint256 tokenId);
    event NFTTransferred(address indexed creator, address indexed receiver,string tokenUri, uint256 tokenId);
    event NFTUnlisted(address indexed seller, uint256 indexed tokenId,string tokenUri);

    function initialize(address token) public initializer {
        __ERC721_init("CryptoCrafters", "CC");
        __Ownable_init(msg.sender);
        tokenAddress = token;
    }

    function createToken(address to, string memory tokenURI) public returns (uint256) {
        require(to != address(0), "Has Zero Address");
        uint256 newTokenId = _tokenIds += 1;
        _mint(to, newTokenId);
        _setTokenURI(newTokenId, tokenURI);
         emit NFTCreated(to, tokenURI, newTokenId);
        return newTokenId;
    }


     function listNft(uint256 tokenId, uint256 price) public {
        require(msg.sender == ownerOf(tokenId), "You are not the owner of TokenId");
        require(price > 0, "Price cannot be set to zero");
        listedNFT[tokenId] = true;
        priceofNFT[tokenId] = price;
        approve(address(this), tokenId);
        emit NFTListed(msg.sender, tokenId, price, tokenURI(tokenId));
    }

    function buy(uint256 tokenId, uint256 _amount) public {
        require(listedNFT[tokenId], "NFT is not listed for sale");
        require(msg.sender != ownerOf(tokenId), "You cannot buy your own Token");
        require(_amount == priceofNFT[tokenId], "You don't have enough Tokens to buy it");
        address seller = ownerOf(tokenId);
        address buyer = msg.sender;
        // Ensure the contract is allowed to spend the buyer's tokens
        IERC20 tokenContract = IERC20(tokenAddress);
        uint256 allowance = tokenContract.allowance(buyer, address(this));
        require(allowance >= _amount, "You must approve the contract to spend your tokens");
        // Transfer tokens from the buyer to the seller
        require(tokenContract.transferFrom(buyer, seller, _amount), "Token transfer failed");
        // Transfer the NFT to the buyer
        IERC721(address(this)).safeTransferFrom(seller, buyer, tokenId);

        listedNFT[tokenId] = false;
        emit NFTBought(seller, buyer, tokenId, tokenURI(tokenId), priceofNFT[tokenId]);
        priceofNFT[tokenId] = 0;
    }




    function removeListing(uint256 tokenId) external {
        require(msg.sender == ownerOf(tokenId), "You are not the owner of TokenId");
        listedNFT[tokenId] = false;
        approve(address(0), tokenId);
        priceofNFT[tokenId] = 0;
        emit NFTUnlisted(msg.sender, tokenId,tokenURI(tokenId));
    }

    function mintAndTransfer(
        address _creator,
        address _to,
        string memory _tokenURI
    ) external returns (uint) {
        require(_creator != address(0), "Has Zero Address");
        require(_to != _creator, "Have same Address");
        require(_to != address(0), "Have zero address");
        uint256 newTokenId = _tokenIds += 1;
        _safeMint(_creator, newTokenId);
        _setTokenURI(newTokenId, _tokenURI);
        _transfer(_creator, _to, newTokenId);
         emit NFTTransferred(_creator,_to,_tokenURI,newTokenId);
        return newTokenId;
    }
}
