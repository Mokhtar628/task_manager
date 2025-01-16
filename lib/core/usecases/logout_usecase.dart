import '../services/user_preferences.dart';

class LogoutUseCase {
  Future<void> execute() async {
    try {
      await UserPreferences.logout();
    } catch (e) {
      throw Exception('Failed to log out');
    }
  }
}
