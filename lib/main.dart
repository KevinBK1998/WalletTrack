import 'package:flutter/material.dart';
import 'widgets/chart.dart';
import 'widgets/transaction_button.dart';
import 'widgets/main_balance.dart';
import 'widgets/new_transaction.dart';
import 'widgets/transaction_list.dart';
import 'models/transaction.dart';

void main() => runApp(MainScreenApp());

class MainScreenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WalletTrack',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomeScreenPage(),
    );
  }
}

class MyHomeScreenPage extends StatefulWidget {
  @override
  State<MyHomeScreenPage> createState() => _MyHomeScreenPageState();
}

class _MyHomeScreenPageState extends State<MyHomeScreenPage> {
  final List<Transaction> _transactions = [];

  double get _balance {
    double totalSum = 0;
    for (var transaction in _transactions) {
      totalSum = totalSum + transaction.amount;
    }
    return totalSum;
  }

  List<Transaction> get _recentTransactions {
    return _transactions
        .where(
            (tx) => tx.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  void _startAddTransaction(BuildContext ctx, Function fn) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: NewTransaction(fn));
        });
  }

  void _addOutgoingTransaction(String title, String category, double amount) {
    var newTx = Transaction(
        id: DateTime.now().toString(),
        amount: -amount,
        title: title,
        category: category,
        date: DateTime.now());
    setState(() {
      _transactions.add(newTx);
    });
  }

  void _addIncomingTransaction(String title, String category, double amount) {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('WalletTrack Home Page'),
        actions: [
          IconButton(
              onPressed: () =>
                  _startAddTransaction(context, _addIncomingTransaction),
              icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BalanceText(_balance),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TransactionButton(_startAddTransaction, _addIncomingTransaction,
                    'Add Income', Colors.green),
                TransactionButton(_startAddTransaction, _addOutgoingTransaction,
                    'Add Expense', Colors.red),
              ],
            ),
            Chart(_recentTransactions),
            TransactionList(_transactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddTransaction(context, _addIncomingTransaction),
        child: Icon(Icons.add),
      ),
    );
  }
}
