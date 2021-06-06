import 'package:budget_tracker/components/expense_list.dart';
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
    // ThemeData themeData = Theme.of(context);
    return MaterialApp(
      title: 'Spendee',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white),
      home: ExpenseList(),
    );
  }
}
