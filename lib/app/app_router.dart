import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3_dapp/views/home_view.dart';
import 'package:web3_dapp/views/send_transaction_view.dart';
import 'package:web3_dapp/views/wallet_balance_view.dart';
import 'package:web3_dapp/viewmodels/web3_viewmodel.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeView());
      case '/wallet-balance':
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => Web3ViewModel(),
            child: WalletBalanceView(),
          ),
        );
      case '/send-transaction':
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => Web3ViewModel(),
            child: SendTransactionView(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
