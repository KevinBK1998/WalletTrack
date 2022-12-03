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
        height: 75,
        margin: const EdgeInsets.all(10),
        child:
        FittedBox(
          child: Text(
            'Rs.${balance.abs().toStringAsFixed(2)}',
            style: TextStyle(
                fontSize: 28,
                color: balance.isNegative ? Colors.red : Colors.green),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
