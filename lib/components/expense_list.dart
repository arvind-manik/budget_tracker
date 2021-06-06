import 'package:budget_tracker/components/expense_chart.dart';
import 'package:budget_tracker/constants.dart';
import 'package:budget_tracker/expense_repo.dart';
import 'package:budget_tracker/models/expense_entry.dart';
import 'package:budget_tracker/models/failure.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseList extends StatefulWidget {
  @override
  _ExpenseListState createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  late Future<List<ExpenseEntry>> _expenses;

  @override
  void initState() {
    super.initState();
    _expenses = ExpenseRepository().getEntries();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _expenses = ExpenseRepository().getEntries();
        setState(() {});
      },
      child: FutureBuilder<List<ExpenseEntry>>(
        future: _expenses,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //Pie chart and expense list placeholder
            final expenseEntries = snapshot.data;
            return ListView.builder(
                itemCount: expenseEntries!.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return ExpenseChart(expenseEntries: expenseEntries);
                  }

                  final entry = expenseEntries[index - 1];
                  final Color entryBGColor =
                      ExpenseEntry.getBGColor(entry.getCategory());
                  final Color entryTextColor =
                      ExpenseEntry.getTextColor(entry.getCategory());
                  TextStyle entryTextStyle = TextStyle(color: entryTextColor);

                  //Each list item goes here
                  return Container(
                      margin: BTUI.edge8,
                      decoration: BoxDecoration(
                          color: entryBGColor,
                          borderRadius: BTUI.radius10,
                          border: Border.all(width: 2.0, color: entryBGColor),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 2),
                                blurRadius: 6.0)
                          ]),
                      //Expense list item content
                      child: ListTile(
                          //Expense name
                          title: Text(entry.getName(), style: entryTextStyle),
                          //Expense category and time
                          subtitle: Text(
                              '${entry.getCategory()} • ${DateFormat.yMd().format(entry.getDate())}',
                              style: entryTextStyle),
                          //Expense
                          trailing: Text(
                              '-₹${entry.getPrice().toStringAsFixed(2)}',
                              style: entryTextStyle)));
                });
          } else if (snapshot.hasError) {
            //Error handling
            final failure = snapshot.error as BTError;
            return Center(child: Text(failure.message));
          }

          //Loader returned synchronously
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
