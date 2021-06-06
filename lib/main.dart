import 'package:budget_tracker/constants.dart';
import 'package:budget_tracker/expense_repo.dart';
import 'package:budget_tracker/models/expense_entry.dart';
import 'package:budget_tracker/models/failure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
      home: Budgeter(),
    );
  }
}

class Budgeter extends StatefulWidget {
  @override
  _BudgeterState createState() => _BudgeterState();
}

class _BudgeterState extends State<Budgeter> {
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
                    return Container(
                      margin: BTUI.margin2,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BTUI.radius10,
                          border: Border.all(
                              width: 2.0, color: ExpenseEntry.getColor(entry)),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 2),
                                blurRadius: 6.0)
                          ]),
                    );
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
