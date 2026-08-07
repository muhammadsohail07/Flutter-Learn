import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_series/Tasks/Quote%20App/modelquoteapp.dart';

class ServiceQuoteApp {
  Future<List<Quote>> getQuotes() async {
    final response = await http.get(
      Uri.parse("https://api.jsonbin.io/v3/b/6a74c9b3f5f4af5e29f3e532"),
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      // JSONBin data ko 'record' key ke andar wrap karta hai
      final List<dynamic> jsonList = decoded['record'];
      return jsonList.map<Quote>((json) => Quote.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load quotes');
    }
  }
}