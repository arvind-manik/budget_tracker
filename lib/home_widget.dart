import 'package:budget_tracker/components/expense_list.dart';
import 'package:budget_tracker/constants.dart';
import 'package:flutter/material.dart';

class BTHome extends StatefulWidget {
  BTHome({Key? key}) : super(key: key);

  @override
  _BTHomeState createState() => _BTHomeState();
}

class _BTHomeState extends State<BTHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: const Text('Spendee')),
        body: ExpenseList(),
        backgroundColor: Theme.of(context).primaryColor,
        floatingActionButton: FloatingActionButton(
            onPressed: () => setState(() => {}),
            tooltip: BTResource.ADD_TRANSACTION,
            child: const Icon(Icons.add),
            backgroundColor: Theme.of(context).accentColor),
      ),
    );
  }
}
