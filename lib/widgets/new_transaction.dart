import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  final bool isExpense;

  NewTransaction(this.addTx, this.isExpense);

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
        margin: EdgeInsets.all(10),
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
              margin: EdgeInsets.all(10),
              child: TextButton(
                onPressed: submitData,
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.blue, fontSize: 18),
                ),
              ),
            ),
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
    if (widget.isExpense) {
      enteredAmount = -enteredAmount;
    }
    widget.addTx(enteredTitle, enteredCategory, enteredAmount);
    Navigator.of(context).pop();
  }
}
