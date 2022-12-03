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
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              headline5: TextStyle(
                color: Theme.of(context).hintColor,
                fontStyle: FontStyle.italic,
                fontSize: 12,
              ),
            ),
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

  void _startAddTransaction(BuildContext ctx, bool isExpense) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: NewTransaction(_addTransaction, isExpense));
        });
  }

  void _addTransaction(
      String title, String category, double amount, DateTime date) {
    var newTx = Transaction(
        id: DateTime.now().toString(),
        amount: amount,
        title: title,
        category: category,
        date: date);
    setState(() {
      _transactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WalletTrack Home Page'),
        actions: [IconButton(onPressed: () => {}, icon: Icon(Icons.add))],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BalanceText(_balance),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TransactionButton(
                    _startAddTransaction, false, 'Add Income', Colors.green),
                TransactionButton(
                    _startAddTransaction, true, 'Add Expense', Colors.red),
              ],
            ),
            Chart(_recentTransactions),
            TransactionList(_transactions, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: Icon(Icons.add),
      ),
    );
  }
}
