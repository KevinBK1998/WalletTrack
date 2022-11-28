import 'package:flutter/material.dart';
import 'package:wallet_tracker/widgets/user_transaction.dart';
import 'widgets/transaction_button.dart';
import 'widgets/main_balance.dart';

void main() => runApp(MainScreenApp());

class MainScreenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WalletTrack',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('WalletTrack Home Page'),
        ),
        body: MyHomeScreenPage(),
      ),
    );
  }
}

class MyHomeScreenPage extends StatefulWidget {
  @override
  State<MyHomeScreenPage> createState() => _MyHomeScreenPageState();
}

class _MyHomeScreenPageState extends State<MyHomeScreenPage> {
  double _balance = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BalanceText(_balance),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TransactionButton(addIncome, 'Add Income', Colors.green),
              TransactionButton(addExpense, 'Add Expense', Colors.red),
            ],
          ),
          UserTransaction(),
        ],
      ),
    );
  }

  void addIncome() {
    setState(() {
      _balance = _balance + 1;
    });
  }

  void addExpense() {
    setState(() {
      _balance = _balance - 1;
    });
  }
}
