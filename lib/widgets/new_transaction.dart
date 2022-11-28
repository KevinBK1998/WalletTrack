import 'package:flutter/material.dart';
import 'transaction_button.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final categoryController = TextEditingController();
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              autocorrect: true,
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              autofocus: true,
              controller: amountController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Category'),
              autocorrect: true,
              controller: categoryController,
            ),
            Container(
                alignment: Alignment.centerRight,
                child: TransactionButton(
                    () => addTx(
                        titleController.text,
                        double.parse(amountController.text),
                        categoryController.text),
                    'Submit',
                    Colors.blue)),
          ],
        ),
      ),
    );
  }
}
