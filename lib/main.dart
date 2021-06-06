import 'package:budget_tracker/home_widget.dart';
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
        theme: ThemeData(
            primaryColor: Colors.black,
            accentColor: Colors.blue[100],
            primaryColorLight: Colors.black87,
            hintColor: Colors.white70,
            textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.white70, displayColor: Colors.white70)),
        home: BTHome());
  }
}
