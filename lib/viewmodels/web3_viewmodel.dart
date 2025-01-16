import 'package:flutter/material.dart';
import 'package:web3_dapp/data/services/blockchain_service.dart';

class Web3ViewModel extends ChangeNotifier {
  final BlockchainService _blockchainService = BlockchainService();
  String balance = "0";
  String transactionHash = "";
  bool isLoading = false;

  Future<void> fetchBalance(String address) async {
    try {
      isLoading = true;
      notifyListeners();

      final result = await _blockchainService.getBalance(address);
      balance = result.getInEther.toString();
    } catch (e) {
      balance = "Error fetching balance";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> sendTransaction(String toAddress, double amount) async {
    try {
      isLoading = true;
      notifyListeners();

      final hash = await _blockchainService.sendTransaction(toAddress, amount);
      transactionHash = hash;
    } catch (e) {
      transactionHash = "Error sending transaction";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

