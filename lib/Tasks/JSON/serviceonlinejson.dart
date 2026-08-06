import 'dart:convert';
import 'package:http/http.dart' as http;
import 'modelonlinejson.dart';

class OnlineService {
  // Load and decode the JSON File
  Future<Person> loadPerson() async {
    final response = await http
        .get(Uri.parse('https://jsonguide.technologychannel.org/info.json'));
    if (response.statusCode == 200) {
      // json.decode() is used to convert JSON String to JSON Map
      final jsonResponse = json.decode(response.body);
      return Person.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load data from server');
    }
  }
}