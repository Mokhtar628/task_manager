import 'dart:convert';
import 'package:http/http.dart' as http;

import '../services/user_preferences.dart';

class ApiClient {
  // Singleton
  ApiClient._internal();

  static final ApiClient _instance = ApiClient._internal();

  factory ApiClient() {
    return _instance;
  }

  final String baseUrl = 'https://dummyjson.com/auth';


  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> get(String endpoint, {String? token}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$endpoint'),
      headers: token != null
          ? {'Authorization': 'Bearer $token'}
          : {'Content-Type': 'application/json'},
    );
    return jsonDecode(response.body);
  }

  Future<Map<String, String>> refreshSession({int expiresInMins = 30}) async {
    final url = Uri.parse('$baseUrl/auth/refresh');

    final refreshToken = await UserPreferences.getRefreshToken();
    final accessToken = await UserPreferences.getAccessToken();

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json','Authorization':accessToken!},
      body: jsonEncode({
        'refreshToken': refreshToken,
        'expiresInMins': 30,
      }),
    );


    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return {
        'accessToken': data['accessToken'],
        'refreshToken': data['refreshToken'],
      };
    } else {
      throw Exception(response.body);
    }
  }
}
