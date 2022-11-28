import 'package:flutter/material.dart';
import 'transaction_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  final categoryController = TextEditingController();

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
              autofocus: true,
              controller: titleController,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Category'),
              autocorrect: true,
              controller: categoryController,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
              controller: amountController,
            ),
            Container(
                alignment: Alignment.centerRight,
                child: TransactionButton(
                    submitDataWithPosParams, () {}, 'Submit', Colors.blue)),
          ],
        ),
      ),
    );
  }

  void submitData() {
    var enteredTitle = titleController.text;
    var enteredCategory = categoryController.text;
    var enteredAmount = double.parse(amountController.text);
    print('$enteredTitle, $enteredCategory, $enteredAmount');
    if (enteredTitle.isEmpty || enteredCategory.isEmpty || enteredAmount <= 0) {
      return;
    }
    widget.addTx(enteredTitle, enteredCategory, enteredAmount);
    Navigator.of(context).pop();
  }

  void submitDataWithPosParams(BuildContext ctx, Function fn) {
    submitData();
  }
}
