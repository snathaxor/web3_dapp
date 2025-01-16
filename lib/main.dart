import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3_dapp/viewmodels/web3_viewmodel.dart';
import 'package:web3_dapp/app/app_router.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Web3ViewModel>(create: (_) => Web3ViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Dapp by Syed Naseeb Ali Tirmizi',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
