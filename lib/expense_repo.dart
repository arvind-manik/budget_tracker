import 'dart:convert';
import 'dart:io';

import 'package:budget_tracker/constants.dart';
import 'package:budget_tracker/models/expense_entry.dart';
import 'package:budget_tracker/models/failure.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ExpenseRepository {
  final http.Client _client;

  ExpenseRepository({http.Client? client}) : _client = client ?? http.Client();

  void dispose() {
    _client.close();
  }

  Future<List<ExpenseEntry>> getEntries() async {
    try {
      final apiUrl =
          '${BTConstants.BASE_URL}databases/${dotenv.env['NOTION_DB_ID']}/query';

      final response = await _client.post(Uri.parse(apiUrl), headers: {
        HttpHeaders.authorizationHeader:
            'Bearer ${dotenv.env['NOTION_API_KEY']}',
        'Notion-Version': '2021-05-13'
      });

      if (response.statusCode == HttpStatus.ok) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return (data[BTAPIKeys.RESULTS] as List)
            .map((entry) => ExpenseEntry.fromMap(entry))
            .toList()
              ..sort((entryOne, entryTwo) =>
                  entryTwo.getDate().compareTo(entryOne.getDate()));
      } else {
        throw const BTError(message: BTResource.REQUEST_FAILURE);
      }
    } catch (_e, stackTrace) {
      print(stackTrace);
      throw const BTError(message: BTResource.GENERIC_FAILURE);
    }
  }
}
