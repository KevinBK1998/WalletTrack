import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text('No transactions added yet'),
                SizedBox(
                  height: 50,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/snooze.png',
                      fit: BoxFit.cover,
                    )),
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                            padding: EdgeInsets.all(5),
                            child: FittedBox(
                                child: Text(transactions[index].category)))),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMEd().format(transactions[index].date),
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    trailing: Card(
                      borderOnForeground: true,
                      elevation: 5,
                      color: transactions[index].amount.isNegative
                          ? Colors.red
                          : Colors.green,
                      child: SizedBox(
                        width: 75,
                        height: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: FittedBox(
                            child: Text(
                              'Rs.${transactions[index].amount.abs().toStringAsFixed(2)}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
