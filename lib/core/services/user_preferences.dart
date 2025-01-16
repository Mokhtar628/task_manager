import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/auth/domain/entities/user.dart';

class UserPreferences {
  static const String userKey = 'USER_KEY';
  static const String accessTokenKey = 'ACCESS_TOKEN';
  static const String refreshTokenKey = 'REFRESH_TOKEN';

  static Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    String userJson = userToJson(user);
    await prefs.setString(userKey, userJson);
  }

  static Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString(userKey);

    if (userJson != null) {
      return userFromJson(userJson);
    }
    return null;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(userKey);
    await prefs.remove(accessTokenKey);
    await prefs.remove(refreshTokenKey);
  }

  static String userToJson(User user) {
    final Map<String, dynamic> data = user.toMap();
    return jsonEncode(data); // Convert to JSON string
  }

  static User userFromJson(String json) {
    try {
      Map<String, dynamic> data = jsonDecode(json);

      return User.fromJson(data);
    } catch (e) {
      throw Exception("Failed to decode user JSON");
    }
  }

  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(accessTokenKey);
  }

  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(refreshTokenKey);
  }

  static Future<void> saveTokens(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(accessTokenKey, accessToken);
    await prefs.setString(refreshTokenKey, refreshToken);
  }
}
