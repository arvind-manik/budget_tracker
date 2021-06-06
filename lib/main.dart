import 'package:budget_tracker/constants.dart';
import 'package:budget_tracker/expense_repo.dart';
import 'package:budget_tracker/models/expense_entry.dart';
import 'package:budget_tracker/models/failure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(BaseApp());
}

class BaseApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spendee',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white),
      home: ExpenseList(),
    );
  }
}

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
    return Scaffold(
      appBar: AppBar(title: const Text('Spendee')),
      body: FutureBuilder<List<ExpenseEntry>>(
        future: _expenses,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //Pie chart and expense list placeholder
            final expenseEntries = snapshot.data;
            return ListView.builder(
                itemCount: expenseEntries?.length,
                itemBuilder: (BuildContext context, int index) {
                  final entry = expenseEntries?[index];
                  if (entry != null) {
                    final Color entryBGColor = ExpenseEntry.getBGColor(entry);
                    final Color entryTextColor =
                        ExpenseEntry.getTextColor(entry);

                    return Container(
                        margin: BTUI.margin2,
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
                        child: ListTile(
                            title: Text(entry.getName(),
                                style: TextStyle(color: entryTextColor)),
                            subtitle: Text(
                                '${entry.getCategory()} • ${DateFormat.yMd().format(entry.getDate())}',
                                style: TextStyle(color: entryTextColor)),
                            trailing: Text(
                                '-₹${entry.getPrice().toStringAsFixed(2)}',
                                style: TextStyle(color: entryTextColor))));
                  } else {
                    return Container(child: Text('Unknown entry'));
                  }
                });
          } else if (snapshot.hasError) {
            //Error handling
            final failure = snapshot.error as BTError;
            return Center(child: Text(failure.message));
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
