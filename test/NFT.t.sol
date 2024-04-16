// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import {Test, console} from "lib/forge-std/src/Test.sol";
import {NFT} from "../src/NFT.sol";
import {MarketPlaceToken} from "../src/Token.sol";

contract NFT_Test is Test {
  NFT public nft_contract;
  MarketPlaceToken public token_contract;

   //key creation for nft creator {user : nft creator}
    uint256 internal creatorPrivateKey;
    address internal creator;


  function setUp() public{

        //maker private key
        creatorPrivateKey = 0xA11CE;
        //maker public address
        creator = vm.addr(creatorPrivateKey);

        nft_contract = new NFT();
        token_contract= new MarketPlaceToken();
        //initialize the nft contract
        nft_contract.initialize(address(token_contract));

        assert(nft_contract.tokenAddress()==address(token_contract));
    }


        /**
     * @notice create new nft as creator
     * Function be able to create a new nft
     */
    //creating an NFT testing nft contract function
    function test_createNFT() public{
        vm.prank(creator);
        nft_contract.createToken(creator,"Some URI");
        assertEq(nft_contract.ownerOf(1),creator);
        vm.stopPrank();
    }

      /**
     * @notice create new nft as creator
     * Function be able to create a new nft
     */
    //creating an NFT testing nft contract function
    function test_createNFT_transferNFT() public{
        vm.prank(creator);
        nft_contract.mintAndTransfer(creator,address(1),"someUri");
        assertEq(nft_contract.ownerOf(1),address(1));
        vm.stopPrank();
    }


}
