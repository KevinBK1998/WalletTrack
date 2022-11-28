import 'package:flutter/material.dart';
import 'package:wallet_tracker/widgets/new_transaction.dart';
import 'package:wallet_tracker/widgets/user_transaction.dart';
import 'widgets/transaction_list.dart';
import 'models/transaction.dart';
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
          title: Text('WalletTrack Home Page'),
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

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final categoryController = TextEditingController();

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
    var amount = double.parse(amountController.text);
    setState(() {
      // _transactions.add(Transaction(
      //     id: 't4',
      //     amount: double.parse(amountController.text),
      //     title: titleController.text,
      //     category: categoryController.text,
      //     date: DateTime.now()));
      _balance = _balance + amount;
    });
  }

  void addExpense() {
    var amount = double.parse(amountController.text);
    setState(() {
      // _transactions.add(Transaction(
      //     id: 't3',
      //     amount: -double.parse(amountController.text),
      //     title: titleController.text,
      //     category: categoryController.text,
      //     date: DateTime.now()));
      _balance = _balance - amount;
    });
  }
}
