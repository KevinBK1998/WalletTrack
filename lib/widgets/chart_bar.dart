import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingAmountPct;

  ChartBar(this.label, this.spendingAmount, this.spendingAmountPct);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          FittedBox(
          child: Text('${spendingAmount.toStringAsFixed(2)}')),
          SizedBox(
            height: 4,
          ),
          Container(
              height: 60,
              width: 10,
              child: Stack(children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10)),
                ),
                FractionallySizedBox(
                  heightFactor: spendingAmountPct,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )
              ])),
          SizedBox(
            height: 4,
          ),
          Text('${label.substring(0, 1)}'),
        ],
      ),
    );
  }
}