import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  final bool isExpense;

  NewTransaction(this.addTx, this.isExpense);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  final _categoryController = TextEditingController();
  DateTime? _selectedDate;

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
              controller: _titleController,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Category'),
              autocorrect: true,
              controller: _categoryController,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
              controller: _amountController,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No date chosen'
                        : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}',
                  ),
                ),
                TextButton(
                    onPressed: () => _presentDatePicker(context),
                    child: Text('Choose date')),
              ],
            ),
            Container(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: submitData,
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _presentDatePicker(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022, 12),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void submitData() {
    var enteredTitle = _titleController.text;
    var enteredCategory = _categoryController.text;
    var enteredAmount = double.parse(_amountController.text);
    print('$enteredTitle, $enteredCategory, $enteredAmount, $_selectedDate');
    if (enteredTitle.isEmpty ||
        enteredCategory.isEmpty ||
        _selectedDate == null ||
        enteredAmount <= 0) {
      return;
    }
    if (widget.isExpense) {
      enteredAmount = -enteredAmount;
    }
    widget.addTx(enteredTitle, enteredCategory, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }
}
