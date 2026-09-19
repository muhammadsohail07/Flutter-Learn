import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_series/Tasks/API/LOGIN/loginmodel.dart';

class SessionManager {
  static const String _keyUser = 'logged_in_user';

  static Future<void> saveSession(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUser, jsonEncode(user.toJson()));
  }

  static Future<UserModel?> getSession() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_keyUser);

    if (userJson == null) return null;

    return UserModel.fromJson(jsonDecode(userJson));
  }

  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUser);
  }
}