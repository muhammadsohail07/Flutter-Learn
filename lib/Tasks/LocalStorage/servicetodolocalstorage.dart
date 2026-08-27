import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_series/Tasks/LocalStorage/modeltodolocalstorage.dart';

class todoStorageService{
  static const String _storageKey = "todoList";

  Future<List<todo>> loadtodo () async{
    final prefs = await SharedPreferences.getInstance();
    final  String? todoString = prefs.getString(_storageKey);
    if (todoString == null) return [];
    final List<dynamic> decoded = jsonDecode(todoString);
    return decoded.map((item) => todo.fromJson(item)).toList();
  }

}