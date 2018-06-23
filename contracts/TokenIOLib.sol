pragma solidity 0.4.24;

import "./SafeMath.sol";
import "./TokenIOStorage.sol";


library TokenIOLib {

  using SafeMath for uint;

  struct Data {
    TokenIOStorage Storage;
  }

  event LogDeposit(string currency, address indexed account, uint amount, string issuerFirm);
  event LogWithdraw(string currency, address indexed account, uint amount, string issuerFirm);
  event LogTransfer(string currency, address indexed from, address indexed to, uint amount, bytes data);
  event LogKYCApproval(address indexed account, bool status, string issuerFirm);
  event LogAccountStatus(address indexed account, bool status, string issuerFirm);


  function setTokenName(Data storage self, string tokenName) internal returns (bool) {
    bytes32 id = keccak256(abi.encode('token.name', address(this)));
    self.Storage.setString(id, tokenName);
    return true;
  }

  function setTokenSymbol(Data storage self, string tokenSymbol) internal returns (bool) {
    bytes32 id = keccak256(abi.encode('token.symbol', address(this)));
    self.Storage.setString(id, tokenSymbol);
    return true;
  }

  function setTokenTLA(Data storage self, string tokenTLA) internal returns (bool) {
    bytes32 id = keccak256(abi.encode('token.tla', address(this)));
    self.Storage.setString(id, tokenTLA);
    return true;
  }

  function setTokenVersion(Data storage self, string tokenVersion) internal returns (bool) {
    bytes32 id = keccak256(abi.encode('token.version', address(this)));
    self.Storage.setString(id, tokenVersion);
    return true;
  }

  function setTokenDecimals(Data storage self, uint tokenDecimals) internal returns (bool) {
    bytes32 id = keccak256(abi.encode('token.decimals', address(this)));
    self.Storage.setUint(id, tokenDecimals);
    return true;
  }

  function setFeeBPS(Data storage self, uint tokenFeeBPS) internal returns (bool) {
    bytes32 id = keccak256(abi.encode('fee.bps', address(this)));
    self.Storage.setUint(id, tokenFeeBPS);
    return true;
  }

  function setFeeMin(Data storage self, uint tokenFeeMin) internal returns (bool) {
    bytes32 id = keccak256(abi.encode('fee.min', address(this)));
    self.Storage.setUint(id, tokenFeeMin);
    return true;
  }

  function setFeeMax(Data storage self, uint tokenFeeMax) internal returns (bool) {
    bytes32 id = keccak256(abi.encode('fee.max', address(this)));
    self.Storage.setUint(id, tokenFeeMax);
    return true;
  }

  function setFeeFlat(Data storage self, uint tokenFeeFlat) internal returns (bool) {
    bytes32 id = keccak256(abi.encode('fee.flat', address(this)));
    self.Storage.setUint(id, tokenFeeFlat);
    return true;
  }

  function setFeeAccount(Data storage self, address tokenFeeAccount) internal returns (bool) {
    bytes32 id = keccak256(abi.encode('fee.account', address(this)));
    self.Storage.setAddress(id, tokenFeeAccount);
    return true;
  }

  function setTokenNameSpace(Data storage self, string currency) internal returns (bool) {
    bytes32 id = keccak256(abi.encode('token.namespace', currency));
    self.Storage.setAddress(id, address(this));
    return true;
  }

  function setKYCApproval(Data storage self, address account, bool isApproved, string issuerFirm) internal returns (bool) {
      bytes32 id = keccak256(abi.encode('account.kyc', account));
      self.Storage.setBool(id, isApproved);

      emit LogKYCApproval(account, isApproved, issuerFirm);
      return true;
  }

  function setAccountStatus(Data storage self, address account, bool isAllowed, string issuerFirm) internal returns (bool) {
    bytes32 id = keccak256(abi.encode('account.allowed', account));
    self.Storage.setBool(id, isAllowed);

    emit LogAccountStatus(account, isAllowed, issuerFirm);
    return true;
  }

  function getKYCApproval(Data storage self, address account) internal view returns (bool) {
      bytes32 id = keccak256(abi.encode('account.kyc', account));
      return self.Storage.getBool(id);
  }

  function getAccountStatus(Data storage self, address account) internal view returns (bool) {
    bytes32 id = keccak256(abi.encode('account.allowed', account));
    return self.Storage.getBool(id);
  }

  function getTokenNameSpace(Data storage self, string currency) internal view returns (address) {
    bytes32 id = keccak256(abi.encode('token.namespace', currency));
    return self.Storage.getAddress(id);
  }

  function getTokenName(Data storage self, address contractAddress) internal view returns (string) {
    bytes32 id = keccak256(abi.encode('token.name', contractAddress));
    return self.Storage.getString(id);
  }

  function getTokenSymbol(Data storage self, address contractAddress) internal view returns (string) {
    bytes32 id = keccak256(abi.encode('token.symbol', contractAddress));
    return self.Storage.getString(id);
  }

  function getTokenTLA(Data storage self, address contractAddress) internal view returns (string) {
    bytes32 id = keccak256(abi.encode('token.tla', contractAddress));
    return self.Storage.getString(id);
  }

  function getTokenVersion(Data storage self, address contractAddress) internal view returns (string) {
    bytes32 id = keccak256(abi.encode('token.version', contractAddress));
    return self.Storage.getString(id);
  }

  function getTokenDecimals(Data storage self, address contractAddress) internal view returns (uint) {
    bytes32 id = keccak256(abi.encode('token.decimals', contractAddress));
    return self.Storage.getUint(id);
  }

  function getFeeBPS(Data storage self, address contractAddress) internal view returns (uint) {
    bytes32 id = keccak256(abi.encode('fee.bps', contractAddress));
    return self.Storage.getUint(id);
  }

  function getFeeMin(Data storage self, address contractAddress) internal view returns (uint) {
    bytes32 id = keccak256(abi.encode('fee.min', contractAddress));
    return self.Storage.getUint(id);
  }

  function getFeeMax(Data storage self, address contractAddress) internal view returns (uint) {
    bytes32 id = keccak256(abi.encode('fee.max', contractAddress));
    return self.Storage.getUint(id);
  }

  function getFeeFlat(Data storage self, address contractAddress) internal view returns (uint) {
    bytes32 id = keccak256(abi.encode('fee.flat', contractAddress));
    return self.Storage.getUint(id);
  }

  function getFeeAccount(Data storage self, address contractAddress) internal view returns (address) {
    bytes32 id = keccak256(abi.encode('fee.account', contractAddress));
    return self.Storage.getAddress(id);
  }


  function getTokenSupply(Data storage self, string currency) internal view returns (uint) {
    bytes32 id = keccak256(abi.encode('token.supply', currency));
    return self.Storage.getUint(id);
  }

  function getTokenAllowance(Data storage self, string currency, address account, address spender) internal view returns (uint) {
    bytes32 id = keccak256(abi.encode('token.allowance', currency, account, spender));
    return self.Storage.getUint(id);
  }

  function getTokenBalance(Data storage self, string currency, address account) internal view returns (uint) {
    bytes32 id = keccak256(abi.encode('token.balance', currency, account));
    return self.Storage.getUint(id);
  }

  function getTokenFrozenBalance(Data storage self, string currency, address account) internal view returns (uint) {
    bytes32 id = keccak256(abi.encode('token.frozen', currency, account));
    return self.Storage.getUint(id);
  }

  function calculateFees(Data storage self, address contractAddress, uint amount) internal view returns (uint) {

    uint maxFee = self.Storage.getUint(keccak256(abi.encode('fee.max', contractAddress)));
    uint minFee = self.Storage.getUint(keccak256(abi.encode('fee.min', contractAddress)));
    uint bpsFee = self.Storage.getUint(keccak256(abi.encode('fee.bps', contractAddress)));
    uint flatFee = self.Storage.getUint(keccak256(abi.encode('fee.flat', contractAddress)));
    uint fees = ((amount.mul(bpsFee)).div(10000)).add(flatFee);

    if (fees > maxFee) {
      return maxFee;
    } else if (fees < minFee) {
      return minFee;
    } else {
      return fees;
    }
  }

//   function transferERC20(Data storage self, address to, uint amount) internal returns (bool) {
//     require(address(to) != 0x0);

//     uint fees = calculateFees(self, address(this), amount);
//     string memory currency = getTokenSymbol(self, address(this));

//     bytes32 id_a = keccak256(abi.encode('token.balance', currency, msg.sender));
//     bytes32 id_b = keccak256(abi.encode('token.balance', currency, to));
//     bytes32 id_c = keccak256(abi.encode('token.balance', currency, getFeeAccount(self, address(this))));

//     require(self.Storage.setUint(id_a, self.Storage.getUint(id_a).sub(amount.add(fees))));
//     require(self.Storage.setUint(id_b, self.Storage.getUint(id_b).add(amount)));
//     require(self.Storage.setUint(id_c, self.Storage.getUint(id_c).add(fees)));

//     return true;
//   }

  function transfer(Data storage self, string currency, address to, uint amount, bytes data) internal returns (bool) {
    require(address(to) != 0x0);

    // string memory currency = getTokenSymbol(self, address(this));

    bytes32 id_a = keccak256(abi.encode('token.balance', currency, msg.sender));
    bytes32 id_b = keccak256(abi.encode('token.balance', currency, to));
    bytes32 id_c = keccak256(abi.encode('token.balance', currency, getFeeAccount(self, address(this))));

    uint fees = calculateFees(self, address(this), amount);

    require(self.Storage.setUint(id_a, self.Storage.getUint(id_a).sub(amount.add(fees))));
    require(self.Storage.setUint(id_b, self.Storage.getUint(id_b).add(amount)));
    require(self.Storage.setUint(id_c, self.Storage.getUint(id_c).add(fees)));

    emit LogTransfer(currency, msg.sender, to, amount, data);

    return true;
  }

  function transferFromERC20(Data storage self, address from, address to, uint amount) internal returns (bool) {
    require(address(to) != 0x0);

    uint fees = calculateFees(self, address(this), amount);
    string memory currency = getTokenSymbol(self, address(this));

    bytes32 id_a = keccak256(abi.encode('token.balance', currency, from));
    bytes32 id_b = keccak256(abi.encode('token.balance', currency, to));
    bytes32 id_c = keccak256(abi.encode('token.balance', currency, getFeeAccount(self, address(this))));
    bytes32 id_d = keccak256(abi.encode('token.allowance', currency, from, msg.sender));

    require(self.Storage.setUint(id_d, self.Storage.getUint(id_d).sub(amount)));
    require(self.Storage.setUint(id_a, self.Storage.getUint(id_a).sub(amount.add(fees))));
    require(self.Storage.setUint(id_b, self.Storage.getUint(id_b).add(amount)));
    require(self.Storage.setUint(id_c, self.Storage.getUint(id_c).add(fees)));


    return true;
  }

  function approveERC20(Data storage self, address spender, uint amount) internal returns (bool) {
    string memory currency = getTokenSymbol(self, address(this));

    bytes32 id_a = keccak256(abi.encode('token.allowance', currency, msg.sender, spender));
    bytes32 id_b = keccak256(abi.encode('token.balance', currency, msg.sender));

    require(self.Storage.getUint(id_a) == 0 || amount == 0);
    require(self.Storage.getUint(id_b) >= amount);

    require(self.Storage.setUint(id_a, amount));

    return true;
  }

  function deposit(Data storage self, string currency, address account, uint amount, string issuerFirm) internal returns (bool) {
    bytes32 id_a = keccak256(abi.encode('token.balance', currency, account));
    bytes32 id_b = keccak256(abi.encode('token.issued', currency, issuerFirm));
    bytes32 id_c = keccak256(abi.encode('token.supply', currency));


    require(self.Storage.setUint(id_a, self.Storage.getUint(id_a).add(amount)));
    require(self.Storage.setUint(id_b, self.Storage.getUint(id_b).add(amount)));
    require(self.Storage.setUint(id_c, self.Storage.getUint(id_c).add(amount)));

    emit LogDeposit(currency, account, amount, issuerFirm);

    return true;

  }

  function withdraw(Data storage self, string currency, address account, uint amount, string issuerFirm) internal returns (bool) {
    bytes32 id_a = keccak256(abi.encode('token.balance', currency, account));
    bytes32 id_b = keccak256(abi.encode('token.issued', currency, issuerFirm)); // possible for issuer to go negative
    bytes32 id_c = keccak256(abi.encode('token.supply', currency));


    require(self.Storage.setUint(id_a, self.Storage.getUint(id_a).sub(amount)));
    require(self.Storage.setUint(id_b, self.Storage.getUint(id_b).sub(amount)));
    require(self.Storage.setUint(id_c, self.Storage.getUint(id_c).sub(amount)));

    emit LogWithdraw(currency, account, amount, issuerFirm);

    return true;

  }

  function setRegisteredFirm(Data storage self, string _firmName, bool _authorized) internal returns (bool) {
    bytes32 id = keccak256(abi.encode('registered.firm', _firmName));
    require(self.Storage.setBool(id, _authorized));
    return true;
  }

  function setRegisteredAuthority(Data storage self, string _firmName, address _authority, bool _authorized) internal returns (bool) {
    require(isRegisteredFirm(self, _firmName));
    bytes32 id_a = keccak256(abi.encode('registered.authority', _firmName, _authority));
    bytes32 id_b = keccak256(abi.encode('registered.authority.firm', _authority));

    require(self.Storage.setBool(id_a, _authorized));
    require(self.Storage.setString(id_b, _firmName));

    return true;
  }

  function getFirmFromAuthority(Data storage self, address _authority) internal view returns (string) {
    bytes32 id = keccak256(abi.encode('registered.authority.firm', _authority));
    return self.Storage.getString(id);
  }

  function isRegisteredFirm(Data storage self, string _firmName) internal view returns (bool) {
    bytes32 id = keccak256(abi.encode('registered.firm', _firmName));
    return self.Storage.getBool(id);
  }

  function isRegisteredToFirm(Data storage self, string _firmName, address _authority) internal view returns (bool) {
    bytes32 id = keccak256(abi.encode('registered.authority', _firmName, _authority));
    return self.Storage.getBool(id);
  }

  function isRegisteredAuthority(Data storage self, address _authority) internal view returns (bool) {
    bytes32 id = keccak256(abi.encode('registered.authority', getFirmFromAuthority(self, _authority), _authority));
    return self.Storage.getBool(id);
  }
}
