pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/token/ERC1155/IERC1155.sol";

contract FractionalPolygonNFT is IERC1155 {
  // Mapping from token ID to the address that owns it
  mapping(uint256 => address) private _tokenOwners;

  // Mapping from token ID to the number of tokens that have been minted
  mapping(uint256 => uint256) private _tokenIds;

  // The total number of tokens that have been minted
  uint256 private _totalSupply;

  constructor() public {
    _totalSupply = 0;
  }

  function mint(address _to, uint256[] memory _ids, uint256[] memory _values) public {
    require(msg.sender == address(this));

    for (uint256 i = 0; i < _ids.length; i++) {
      uint256 id = _ids[i];
      uint256 value = _values[i];

      // Mint the tokens and assign them to the specified address
      _tokenOwners[id] = _to;
      _tokenIds[id] = value;
      _totalSupply += value;
    }
  }

  function balanceOf(address _owner, uint256 _id) public view returns (uint256) {
    require(_tokenOwners[_id] == _owner);
    return _tokenIds[_id];
  }

  function totalSupply() public view returns (uint256) {
    return _totalSupply;
  }
}
