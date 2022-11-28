import 'package:flutter/material.dart';

class TransactionButton extends StatelessWidget {
  final VoidCallback pressHandler;
  final String textContent;
  final Color buttonColor;

  TransactionButton(this.pressHandler, this.textContent, this.buttonColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      width: 170,
      child: ElevatedButton(
          onPressed: pressHandler,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(buttonColor)),
          child: Text(textContent, style: TextStyle(color: Colors.white,fontSize: 18))),
    );
  }
}
