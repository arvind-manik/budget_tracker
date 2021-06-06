import 'package:budget_tracker/constants.dart';
import 'package:flutter/material.dart';

class ExpenseEntry {
  final String _name;
  final String _category;
  final double _price;
  final DateTime _dateTime;

  const ExpenseEntry(
      {required name,
      required category,
      required price,
      required DateTime dateTime})
      : _name = name,
        _category = category,
        _price = price,
        _dateTime = dateTime;

  factory ExpenseEntry.fromMap(Map<String, dynamic> entryData) {
    final properties = entryData[APIKeys.PROPERTIES] as Map<String, dynamic>;
    final dateString = properties[APIKeys.DATE_TC]?[APIKeys.DATE]
            ?[APIKeys.START] ??
        Resource.FALLBACK_QMARK;

    return ExpenseEntry(
        name: properties[APIKeys.NAME_TC]?[APIKeys.TITLE]?[0]
                ?[APIKeys.PLAIN_TEXT] ??
            Resource.FALLBACK_QMARK,
        category: properties[APIKeys.CATEGORY_TC]?[APIKeys.SELECT]
                ?[APIKeys.NAME] ??
            Resource.FALLBACK_UNKNOWN,
        price: (properties[APIKeys.PRICE_TC]?[APIKeys.NUMBER] ?? 0).asDouble(),
        dateTime:
            dateString != null ? DateTime.parse(dateString) : DateTime.now());
  }

  static Color getColor(ExpenseEntry entry) {
    String category = entry.getCategory();

    switch (category) {
      case 'Electronics':
        return Colors.blue[200]!;

      case 'Food':
        return Colors.orange[300]!;

      case 'Gaming':
        return Colors.green;

      case 'Clothing':
        return Colors.purple[300]!;

      case 'Fuel':
        return Colors.brown[300]!;

      case 'Health':
        return Colors.red[400]!;

      case 'Home':
        return Colors.orange[800]!;

      case 'Investments':
        return Colors.green[700]!;

      case 'Shopping':
        return Colors.pink[300]!;

      case 'Salary':
        return Colors.green[900]!;

      case 'BDSM Returns':
        return Colors.black26;

      default:
        return Colors.grey[500]!;
    }
  }

  String getName() {
    return this._name;
  }

  String getCategory() {
    return this._category;
  }

  double getPrice() {
    return this._price;
  }

  DateTime getDate() {
    return this._dateTime;
  }
}
