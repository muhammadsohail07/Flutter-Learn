import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_series/Tasks/Quote App/modelquoteapp.dart';

class ServiceQuoteApp {
  Future<List<Quote>> getQuotes() async {
    final response = await http.get(
      Uri.parse("https://api.jsonbin.io/v3/b/6a7617e4da38895dfec71e24"),
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final List<dynamic> jsonList = decoded['record'];
      return jsonList.map<Quote>((json) => Quote.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load quotes');
    }
  }
}