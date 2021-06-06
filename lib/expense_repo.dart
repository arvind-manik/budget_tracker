import 'dart:convert';
import 'dart:io';

import 'package:budget_tracker/models/expense_entry.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ExpenseRepository {
  static const String BASE_URL = 'https://api.notion.com/v1/';
  final http.Client _client;

  ExpenseRepository({http.Client? client}) : _client = client ?? http.Client();

  void dispose() {
    _client.close();
  }

  Future<List<ExpenseEntry>?> getExpenseEntries() async {
    try {
      final apiUrl =
          '${BASE_URL}/databases/${dotenv.env['NOTION_DB_ID']}/query';

      final response = await _client?.post(Uri.parse(apiUrl), headers: {
        HttpHeaders.authorizationHeader:
            'Bearer ${dotenv.env['NOTION_API_KEY']}',
        'Notion-Version': '2021-05-13'
      });

      if (response != null && response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return (data['results'] as List)
            .map((entry) => ExpenseEntry.fromMap(entry))
            .toList();
      }
    } catch (_e) {
      print(_e);
    }

    return null;
  }
}
