import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/entities/user.dart';

class AuthDataSource {
  final ApiClient apiClient;

  AuthDataSource({required this.apiClient});

  Future<User> login(String username, String password) async {
    try {
      final response = await apiClient.post(
        ApiConstants.loginEndpoint,
        {
          'username': username,
          'password': password,
          'expiresInMins': 30,
        },
      );

      // Check if the response has an error message
      if (response.containsKey('message')) {
        throw response['message'];
      }

      // If no error, parse the user data as usual
      return User.fromJson(response);
    } catch (e) {
      rethrow;
      throw Exception(e);
    }
  }


  Future<User> getCurrentUser(String token) async {
    final response = await apiClient.get(ApiConstants.userInfoEndpoint, token: token);
    return User.fromJson(response);
  }

  Future<Map<String, String>> refreshSession({int expiresInMins = 30}) async {
    try {
      final tokens = await apiClient.refreshSession(expiresInMins: expiresInMins);
      return {
        'accessToken': tokens['accessToken']!,
        'refreshToken': tokens['refreshToken']!,
      };
    } catch (e) {
      throw Exception("Failed to refresh session: $e");
    }
  }
}
