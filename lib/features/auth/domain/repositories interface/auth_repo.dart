import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String username, String password);
  Future<User> getCurrentUser(String token);
  Future<bool> refreshSession();
}
