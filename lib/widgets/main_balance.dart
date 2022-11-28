import 'package:flutter/material.dart';

class BalanceText extends StatelessWidget {
  final double balance;

  const BalanceText(this.balance);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        child: Text(
          'Rs.${balance.abs()}',
          style: TextStyle(
              fontSize: 28,
              color: balance.isNegative ? Colors.red : Colors.green),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
