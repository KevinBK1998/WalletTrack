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
      height: 500,
      child: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (ctx, index) {
            return Card(
              elevation: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(color: Colors.blue),
                      alignment: Alignment.center,
                      child: Text(
                        transactions[index].category,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white,fontSize: 12),
                      )),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,

                        child: Text(
                          transactions[index].title,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,

                        child: Text(
                          DateFormat.yMMMEd().format(transactions[index].date),
                          style: const TextStyle(
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                              fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.all(10),
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 2,
                            color: transactions[index].amount.isNegative
                                ? Colors.red
                                : Colors.green,
                          )),
                      alignment: Alignment.center,
                      child: Text(
                        'Rs.${transactions[index].amount.abs().toStringAsFixed(2)}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            color: transactions[index].amount.isNegative
                                ? Colors.red
                                : Colors.green),
                      )),
                ],
              ),
            );
          }),
    );
  }
}
