// import 'package:web3dart/web3dart.dart';
// import 'package:http/http.dart';
// import 'package:web3_dapp/app/app_constants.dart';
//
// class BlockchainService {
//   final Web3Client client;
//
//   BlockchainService()
//       : client = Web3Client(AppConstants.rpcUrl, Client());
//
//   Future<EtherAmount> getBalance(String address) async {
//     final ethereumAddress = EthereumAddress.fromHex(address);
//     return await client.getBalance(ethereumAddress);
//   }
//
//   Future<String> sendTransaction(String toAddress, double amount) async {
//     final credentials = EthPrivateKey.fromHex(AppConstants.privateKey);
//     final to = EthereumAddress.fromHex(toAddress);
//
//     final transaction = Transaction(
//       to: to,
//       value: EtherAmount.fromUnitAndValue(EtherUnit.ether, amount),
//     );
//
//     return await client.sendTransaction(
//       credentials,
//       transaction,
//       chainId: 1,
//     );
//   }
// }



import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'package:web3_dapp/app/app_constants.dart';
import 'dart:convert';

class BlockchainService {
  final Web3Client client;

  BlockchainService()
      : client = Web3Client(AppConstants.rpcUrl, Client());

  /// Validate Ethereum address format.
  bool _isValidAddress(String address) {
    try {
      EthereumAddress.fromHex(address); // Check if the address is valid
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Get wallet balance in Ether.
  Future<EtherAmount> getBalance(String address) async {
    if (!_isValidAddress(address)) {
      throw Exception('Invalid Ethereum address format.');
    }

    final ethereumAddress = EthereumAddress.fromHex(address);
    return await client.getBalance(ethereumAddress);
  }

  /// Validate and send a transaction.
  Future<String> sendTransaction(String toAddress, double amount) async {
    // Check if the recipient address is valid
    if (!_isValidAddress(toAddress)) {
      throw Exception('Invalid recipient Ethereum address format.');
    }

    // Check if the amount is valid (greater than zero)
    if (amount <= 0) {
      throw Exception('Amount must be greater than zero.');
    }

    // Prepare the transaction
    final credentials = EthPrivateKey.fromHex(AppConstants.privateKey);
    final to = EthereumAddress.fromHex(toAddress);

    final transaction = Transaction(
      to: to,
      value: EtherAmount.fromUnitAndValue(EtherUnit.ether, amount),
    );

    try {
      // Send the transaction
      final transactionHash = await client.sendTransaction(
        credentials,
        transaction,
        chainId: 1, // Mainnet (use appropriate chain ID)
      );
      return transactionHash;
    } catch (e) {
      // Handle errors and provide meaningful messages
      throw Exception('Error sending transaction: $e');
    }
  }
}
