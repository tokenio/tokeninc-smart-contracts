pragma solidity 0.4.24;

import "./Ownable.sol";
import "./TokenIOStorage.sol";
import "./TokenIOLib.sol";


/*
COPYRIGHT 2018 Token, Inc.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


@title Standard Fee Contract for Token, Inc. Smart Money System

@author Ryan Tate <ryan.tate@token.io>, Sean Pollock <sean.pollock@token.io>

@notice Contract uses generalized storage contract, `TokenIOStorage`, for
upgradeability of interface contract.

@dev In the event that the main contract becomes deprecated, the upgraded contract
will be set as the owner of this contract, and use this contract's storage to
maintain data consistency between contract.

*/


contract TokenIOFeeContract is Ownable {

	/// @dev Set reference to TokenIOLib interface which proxies to TokenIOStorage
	using TokenIOLib for TokenIOLib.Data;
	TokenIOLib.Data lib;


	/**
	* @notice Constructor method for ERC20 contract
	* @param _storageContract     address of TokenIOStorage contract
	*/
	constructor(address _storageContract) public {
			/// @dev Set the storage contract for the interface
			/// @dev NOTE: This contract will be unable to use the storage constract until
			/// @dev contract address is authorized with the storage contract
			/// @dev Once authorized, Use the `setParams` method to set storage values
			lib.Storage = TokenIOStorage(_storageContract);

			/// @dev set owner to contract initiator
			owner[msg.sender] = true;
	}

	/**
	 * @notice Set Fee Parameters for Fee Contract
	 * @dev The min, max, flat transaction fees should be relative to decimal precision
	 * @param feeBps Basis points transaction fee
	 * @param feeMin Minimum transaction fees
	 * @param feeMax Maximum transaction fee
	 * @param feeFlat Flat transaction fee
	 * returns {"success" : "Returns true if successfully called from another contract"}
	 */
	function setFeeParams(uint feeBps, uint feeMin, uint feeMax, uint feeFlat, bytes feeMsg) public onlyOwner returns (bool success) {
		require(lib.setFeeBPS(feeBps), "Error: Unable to set fee contract basis points.");
		require(lib.setFeeMin(feeMin), "Error: Unable to set fee contract minimum fee.");
		require(lib.setFeeMax(feeMax), "Error: Unable to set fee contract maximum fee.");
		require(lib.setFeeFlat(feeFlat), "Error: Unable to set fee contract flat fee.");
		require(lib.setFeeMsg(feeMsg), "Error: Unable to set fee contract default message.");
		return true;
	}

	/**
	 	* @notice Gets fee parameters
		* @return {
		"bps":"Returns the basis points fee of the TokenIOFeeContract",
		"min":"Returns the min fee of the TokenIOFeeContract",
		"max":"Returns the max fee of the TokenIOFeeContract",
		"flat":"Returns the flat fee of the TokenIOFeeContract",
		"feeContract": "Address of this contract"
	}
	*/
	function getFeeParams() public view returns (uint bps, uint min, uint max, uint flat, bytes feeMsg, address feeContract) {
			return (
					lib.getFeeBPS(address(this)),
					lib.getFeeMin(address(this)),
					lib.getFeeMax(address(this)),
					lib.getFeeFlat(address(this)),
					lib.getFeeMsg(address(this)),
					address(this)
			);
	}

	/**
	 * @notice Returns balance of this contract associated with currency symbol.
	 * @param  currency Currency symbol of the token (e.g. USDx, JYPx, GBPx)
	 * @return {"balance": "Balance of TokenIO TSM currency account"}
	 */
	function getTokenBalance(string currency) public view returns(uint balance) {
		return lib.getTokenBalance(currency, address(this));
	}

	/** @notice Calculates fee of a given transfer amount
	 * @param amount transfer amount
	 * @return { "fees": "Returns the fees associated with this contract"}
	 */
	function calculateFees(uint amount) public view returns (uint fees) {
		return lib.calculateFees(address(this), amount);
	}


	/**
	 * @notice Transfer collected fees to another account; onlyOwner
	 * @param  currency Currency symbol of the token (e.g. USDx, JYPx, GBPx)
	 * @param  to 			Ethereum address of account to send token amount to
	 * @param  amount	  Amount of tokens to transfer
	 * @param  data		  Arbitrary bytes data message to include in transfer
	 * @return {"success": "Returns ture if successfully called from another contract"}
	 */
	function transferCollectedFees(string currency, address to, uint amount, bytes data) public onlyOwner returns (bool success) {
		require(
			lib.forceTransfer(currency, address(this), to, amount, data),
			"Error: unable to transfer fees to account."
		);
		return true;
	}


}
