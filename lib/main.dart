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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(),
    );
  }
}
