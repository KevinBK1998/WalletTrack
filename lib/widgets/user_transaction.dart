import 'package:flutter/material.dart';
import 'new_transaction.dart';
import 'transaction_list.dart';
import '../models/transaction.dart';

class UserTransaction extends StatefulWidget {
  @override
  State<UserTransaction> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  List<Transaction> _transactions = [
    Transaction(
        id: 't1',
        category: 'Video Games',
        amount: -3500,
        title: 'Zelda',
        date: DateTime.now()),
    Transaction(
        id: 't2',
        category: 'Salary',
        amount: 35000,
        title: 'October',
        date: DateTime.now()),
  ];

  void _addTransaction(String title, double amount, String category) {
    var newTx = Transaction(
        id: DateTime.now().toString(),
        amount: amount,
        title: title,
        category: category,
        date: DateTime.now());
    setState(() {
      _transactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(_addTransaction),
        TransactionList(_transactions),
      ],
    );
  }
}
