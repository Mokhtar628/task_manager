import '../../../../core/services/user_preferences.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories interface/auth_repo.dart';
import '../data_source/auth_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl({required this.dataSource});

  @override
  Future<User> login(String username, String password) async {
    try {
      return await dataSource.login(username, password);
    } catch (e) {
      throw e.toString();
    }
  }


  @override
  Future<User> getCurrentUser(String token) async {
    try {
      return await dataSource.getCurrentUser(token);
    } catch (e) {
      throw Exception("Failed to fetch user: $e");
    }
  }

  @override
  Future<bool> refreshSession({int expiresInMins = 30}) async {
    try {
      final tokens = await dataSource.refreshSession(expiresInMins: expiresInMins);
      final newAccessToken = tokens['accessToken'];
      final newRefreshToken = tokens['refreshToken'];

      await UserPreferences.saveTokens(newAccessToken!, newRefreshToken!);

      return true;
    } catch (e) {
      throw e.toString();
    }
  }
}
