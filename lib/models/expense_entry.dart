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
    final properties = entryData[BTAPIKeys.PROPERTIES] as Map<String, dynamic>;
    final dateString = properties[BTAPIKeys.DATE_TC]?[BTAPIKeys.DATE]
            ?[BTAPIKeys.START] ??
        BTResource.FALLBACK_QMARK;

    return ExpenseEntry(
        name: properties[BTAPIKeys.NAME_TC]?[BTAPIKeys.TITLE]?[0]
                ?[BTAPIKeys.PLAIN_TEXT] ??
            BTResource.FALLBACK_QMARK,
        category: properties[BTAPIKeys.CATEGORY_TC]?[BTAPIKeys.SELECT]
                ?[BTAPIKeys.NAME] ??
            BTResource.FALLBACK_UNKNOWN,
        price:
            (properties[BTAPIKeys.PRICE_TC]?[BTAPIKeys.NUMBER] ?? 0).toDouble(),
        dateTime:
            dateString != null ? DateTime.parse(dateString) : DateTime.now());
  }

  static Color getBGColor(ExpenseEntry entry) {
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

  static Color getTextColor(ExpenseEntry entry) {
    const lightBGCategories = ['Electronics', 'Food', 'Health', 'Unknown'];
    return lightBGCategories.contains(entry.getCategory())
        ? Colors.black
        : Colors.white;
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
