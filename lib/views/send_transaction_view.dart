import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3_dapp/viewmodels/web3_viewmodel.dart';

class SendTransactionView extends StatelessWidget {
  final addressController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final web3ViewModel = Provider.of<Web3ViewModel>(context);

    return Scaffold(

      backgroundColor: Color(0xFF121212), // Dark background color
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 70, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
              margin: EdgeInsets.only(bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Send Ethereum',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Enter the recipient address and the amount of ETH to send.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: "Recipient Address",
                labelStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Color(0xFF2A2A2A),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF4A90E2), width: 2),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: "Amount (ETH)",
                labelStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Color(0xFF2A2A2A),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF4A90E2), width: 2),
                ),
              ),
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                final address = addressController.text;
                final amount = double.tryParse(amountController.text);
                if (address.isNotEmpty && amount != null && amount > 0) {
                  web3ViewModel.sendTransaction(address, amount);
                } else {
                  // Handle invalid input
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Please enter a valid address and amount'),
                  ));
                }
              },
              child: Text("Send Transaction",
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
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4A90E2)),
              ),
            SizedBox(height: 20),
            Text(
              "Transaction Hash: ${web3ViewModel.transactionHash}",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
