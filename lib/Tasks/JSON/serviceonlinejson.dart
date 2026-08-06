import 'dart:convert';
import 'package:http/http.dart' as http;
import 'modelonlinejson.dart';

class OnlineService {
  Future<Person> loadPerson() async {
    final response = await http.get(
      Uri.parse('https://api.jsonbin.io/v3/b/6a74c9b3f5f4af5e29f3e532'),
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return Person.fromJson(jsonResponse['record']);
    } else {
      throw Exception('Failed to load data from server');
    }
  }
}