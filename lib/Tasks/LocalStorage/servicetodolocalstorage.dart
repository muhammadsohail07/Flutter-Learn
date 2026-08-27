import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_series/Tasks/LocalStorage/modeltodolocalstorage.dart';

class todoStorageService{
  static const String _storageKey = "todoList";

  Future<List<todo>> loadTodo () async{
    final prefs = await SharedPreferences.getInstance();
    final  String? todoString = prefs.getString(_storageKey);
    if (todoString == null) return [];
    final List<dynamic> decoded = jsonDecode(todoString);
    return decoded.map((item) => todo.fromJson(item)).toList();
  }
  Future<void> saveTodos(List<todo> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded =
    jsonEncode(todos.map((todo) => todo.toJson()).toList());
    await prefs.setString(_storageKey, encoded);
  }

}