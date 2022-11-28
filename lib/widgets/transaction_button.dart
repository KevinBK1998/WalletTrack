import 'package:flutter/material.dart';

class TransactionButton extends StatelessWidget {
  final VoidCallback pressHandler;
  final String textContent;
  final Color buttonColor;

  TransactionButton(this.pressHandler, this.textContent, this.buttonColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      width: 300,
      child: ElevatedButton(
          onPressed: pressHandler,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(buttonColor)),
          child: Text(textContent, style: TextStyle(color: Colors.white,fontSize: 20))),
    );
  }
}