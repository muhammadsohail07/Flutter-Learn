import 'dart:convert';
import 'package:flutter/services.dart';
import 'modellocaljson.dart';

class LocalService {
  // Load and decode the JSON File
  Future<String> _loadPersonAsset() async {
    return await rootBundle.loadString('Assets/Data/info.json');
  }

  // Load and decode the JSON File
  Future<Person> loadPerson() async {
    String jsonString = await _loadPersonAsset();
    // json.decode() is used to convert JSON String to JSON Map
    final jsonResponse = json.decode(jsonString);
    return Person.fromJson(jsonResponse);
  }
}