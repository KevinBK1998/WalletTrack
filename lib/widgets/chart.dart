import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransactions;

  Chart(this._recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSumPerDay = 0;
      for (var transaction in _recentTransactions) {
        if (transaction.date.day == weekDay.day &&
            transaction.date.month == weekDay.month &&
            transaction.date.year == weekDay.year &&
            transaction.amount.isNegative) {
          totalSumPerDay = totalSumPerDay + transaction.amount.abs();
        }
      }
      return {
        'amount': totalSumPerDay,
        'day': '${DateFormat.E().format(weekDay)}'
      };
    }).reversed.toList();
  }

  double get totalSumForWeek {
    return groupedTransactionValues.fold(0, (previousValue, element) {
      return previousValue + (element['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Text(
              'Expense Statistics',
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              '(past week)',
              style: Theme.of(context).textTheme.headline5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: groupedTransactionValues.map((day) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                      day['day'] as String,
                      day['amount'] as double,
                      totalSumForWeek == 0
                          ? 0
                          : (day['amount'] as double) / totalSumForWeek),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
