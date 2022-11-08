// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";


contract CharmingNFT is ERC721{
    using Strings for uint256;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    // function tokenURI(uint256 tokenId) external view returns(string memory);
    mapping(uint256 => string) _tokenURIs;
    bool revealed = false;
    string unpackedURI = "https://gateway.pinata.cloud/ipfs/QmNjfJkVUTR3Z8hAriMqvnwUA69p9M3VJiGj7xAxpPGQrA?filename=unpack.json";

    constructor() ERC721("CharmingNFT", "CFT") {}

    function mint() public {
        uint256 tokenId = _tokenIds.current();
        _mint(msg.sender, tokenId);
        _tokenIds.increment();
        if(revealed == false)
        {
            setTokenURI(tokenId,unpackedURI);
        }
        else
        {
                string memory baseURI = string(abi.encodePacked("https://gateway.pinata.cloud/ipfs/QmZNAJ6pUU99ZfjJKUMLRUHWgdKZwUwAtcggbQh6J8Rssn/", tokenId.toString(), ".json"));
                setTokenURI(tokenId,baseURI);
        }
    }

    function switchRevealed () public {
        uint256 tokenId = _tokenIds.current();
        if (revealed == false) {
            revealed = true;
            for(uint256 i = 0 ; i <tokenId ; i++)
            {
                string memory baseURI = string(abi.encodePacked("https://gateway.pinata.cloud/ipfs/QmZNAJ6pUU99ZfjJKUMLRUHWgdKZwUwAtcggbQh6J8Rssn/", i.toString(), ".json"));
                setTokenURI(i,baseURI);
            }
        }
        else{
            for(uint256 i = 0 ; i <tokenId ; i++)
            {
                            setTokenURI(i,"https://gateway.pinata.cloud/ipfs/QmNjfJkVUTR3Z8hAriMqvnwUA69p9M3VJiGj7xAxpPGQrA?filename=unpack.json");
            }
        }
    }

    function setTokenURI (uint256 tokenId,string memory URI) public{
        _tokenURIs[tokenId]=URI;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        _requireMinted(tokenId);
        return _tokenURIs[tokenId];
    }
}