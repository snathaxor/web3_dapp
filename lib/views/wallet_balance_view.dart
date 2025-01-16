import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3_dapp/viewmodels/web3_viewmodel.dart';

class WalletBalanceView extends StatelessWidget {
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final web3ViewModel = Provider.of<Web3ViewModel>(context);

    return Scaffold(

      backgroundColor: Color(0xFF121212), // Dark background color
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF1E1E1E), // Dark card background
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 7,
                  ),
                ],
              ),
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter Wallet Address',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: addressController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Wallet Address",
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => web3ViewModel.fetchBalance(addressController.text),
              child: Text("Check Balance",
                style: TextStyle(color: Colors.black),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // MetaMask-like blue
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            if (web3ViewModel.isLoading)
              CircularProgressIndicator(
                color: Color(0xFF4A90E2),
              ),
            SizedBox(height: 20),
            if (!web3ViewModel.isLoading)
              Text(
                "Balance: ${web3ViewModel.balance} ETH",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
