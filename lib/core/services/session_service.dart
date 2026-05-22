import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static Future<void> saveLogin(
    String username,
    String password,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('is_login', true);
    await prefs.setString('username', username);
    await prefs.setString('password', password);
  }

  static Future<bool> isLogin() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool('is_login') ?? false;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();
  }
}