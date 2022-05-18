// SPDX-License-Identifier: MIT
// Creator: Chiru Labs

pragma solidity ^0.8.11;

import './ERC721A.sol';
import './extensions/ERC721AQueryable.sol';
import "@openzeppelin/contracts/access/Ownable.sol";

contract WaveFaceA is ERC721A, ERC721AQueryable, Ownable {
    using Strings for uint256;

    string public baseUri;
    string public defaultUri;
    uint256 public revealTime = 5 minutes;
    mapping (uint256 => uint256) public mintedTime;
    mapping (address => bool) public whitelist;

    constructor(string memory _baseUri)
        ERC721A("WaveFaces", "WF")
    {
        baseUri = _baseUri;
        defaultUri = "https://gateway.pinata.cloud/ipfs/Qmd1QYm31sbvGynNbztRY1KG8tCw5zWePvbuZQj8YgCLZh";
    }

    function mint(address to, uint256 quantity) public {
        require(whitelist[msg.sender], "only whitelist user can mint!");
        _safeMint(to, quantity);
    }

    function _baseURI() internal view override returns (string memory) {
        return baseUri;
    }

    function _afterTokenTransfers(
        address from,
        address to,
        uint256 startTokenId,
        uint256 quantity
    ) internal virtual override {
        if (from == address(0)) {
            for (uint256 id = startTokenId; id < startTokenId + quantity; id ++) {
                mintedTime[id] = block.timestamp;
            }
        }

        super._afterTokenTransfers(from, to, startTokenId, quantity);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        if (!_exists(tokenId)) revert URIQueryForNonexistentToken();

        string memory baseURI = _baseURI();
        if(block.timestamp - mintedTime[tokenId] < revealTime) return defaultUri;
        else return bytes(baseURI).length != 0 ? string(abi.encodePacked(baseURI, tokenId.toString(), ".json")) : '';
    }

    // owner functions

    function setBaseURI(string memory _baseUri) public onlyOwner {
        baseUri = _baseUri;
    }

    function setDefaultURI(string memory _defaultUri) public onlyOwner {
        defaultUri = _defaultUri;
    }

    function setRevealTime(uint256 _revealTime) public onlyOwner {
        revealTime = _revealTime;
    }

    function setWhitelist(address user, bool flag) public onlyOwner {
        whitelist[user] = flag;
    }
}
