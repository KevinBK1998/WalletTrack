import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transactions;
  final Function deleteHandler;

  TransactionList(this.transactions, this.deleteHandler);

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  bool showDeleteConfirmation = false;
  int indexSelected = 0;

  void _toggleDeleteIcon(int index) {
    setState(() {
      indexSelected = index;
      showDeleteConfirmation = !showDeleteConfirmation;
    });
    print(
        'showDeleteConfirmation: $showDeleteConfirmation on index: $indexSelected');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 450,
      child: widget.transactions.isEmpty
          ? Column(
              children: [
                Text('No transactions added yet'),
                SizedBox(
                  height: 50,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/snooze.png',
                      fit: BoxFit.cover,
                    )),
              ],
            )
          : ListView.builder(
              itemCount: widget.transactions.length,
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  child: ListTile(
                      onLongPress: () {
                        _toggleDeleteIcon(index);
                      },
                      leading: CircleAvatar(
                          radius: 30,
                          backgroundColor:
                              isDeleteMode(index) ? Colors.white : Colors.blue,
                          child: isDeleteMode(index)
                              ? IconButton(
                                  icon: Icon(Icons.cancel),
                                  onPressed: () => _toggleDeleteIcon(0))
                              : Padding(
                                  padding: EdgeInsets.all(5),
                                  child: FittedBox(
                                      child: Text(
                                    widget.transactions[index].category,
                                    style: TextStyle(color: Colors.white),
                                  )))),
                      title: Text(
                        widget.transactions[index].title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                        isDeleteMode(index)
                            ? 'Delete transaction?'
                            : DateFormat.yMMMEd()
                                .format(widget.transactions[index].date),
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      trailing: isDeleteMode(index)
                          ? IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                showDeleteConfirmation = false;
                                widget.deleteHandler(widget.transactions[index].id);
                              },
                            )
                          : Card(
                              borderOnForeground: true,
                              elevation: 5,
                              color:
                                  widget.transactions[index].amount.isNegative
                                      ? Colors.red
                                      : Colors.green,
                              child: SizedBox(
                                width: 75,
                                height: 30,
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: FittedBox(
                                    child: Text(
                                      'Rs.${widget.transactions[index].amount.abs().toStringAsFixed(2)}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                );
              }),
    );
  }

  bool isDeleteMode(int index) =>
      showDeleteConfirmation && index == indexSelected;
}
