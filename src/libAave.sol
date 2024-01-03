// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {Base64} from "./Base64.sol";

contract l is ERC721, Base64 {

    mapping(uint256 => info) public desc;
    address constant TARGET = 0x87870Bca3F3fD6335C3F4ce8392D69350B4fA4E2; // pool.sol

    struct info {
        string name;                  // name that the user wants to give to their nft
    }

    constructor() ERC721("Track", "TRACK") {}

    function mint(
        address to, 
        uint256 _tokenId, 
        string memory _name) 
    public {
        _safeMint(to, _tokenId);
        setDesc(_tokenId, _name);
    }

    function setDesc(uint _tokenId, string memory _name) public{
        require(ownerOf(_tokenId) == msg.sender, "You are not the owner");
        desc[_tokenId] = info(_name);
    }

    function getSvg(uint tokenId) public view returns (string memory) {
        string memory output;
        info storage description = desc[tokenId];
        (,bytes memory _data) = (TARGET).staticcall(abi.encodeWithSignature("getUserAccountData(address)",ownerOf(tokenId)));
        (uint totalCollateralBase, uint totalDebtBase, uint availableBorrowsBase, uint currentLiquidationThreshold, uint ltv, uint healthFactor) = abi.decode(_data,(uint,uint, uint, uint, uint, uint));
        string memory svg;
        svg = concatenateStrings("<svg width='250' height='400' xmlns='http://www.w3.org/2000/svg'><style>text{font-family:Arial,sans-serif;font-size:24px;fill:#fff;text-anchor:middle}</style><rect width='100%' height='100%'/><text x='125' y='150' style='font-weight:700;fill:#0af'>",description.name,"</text><text x='125' y='250' style='font-style:italic;fill:#f50'>",output,"</text></svg>");
        return svg;
    }    

    function tokenURI(uint256 tokenId) view override(ERC721) public returns(string memory) {
        string memory json = Base64.encode(
            bytes(string(
                abi.encodePacked(
                    '{"name": "', desc[tokenId].name, '",',
                    '"image_data": "', getSvg(tokenId), '"}'
                )
            ))
        );
        return string(abi.encodePacked('data:application/json;base64,', json));
    }    
}
