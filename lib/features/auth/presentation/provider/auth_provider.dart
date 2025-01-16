import 'package:flutter/material.dart';
import '../../../../core/errors/errors_handling.dart';
import '../../../../core/services/jwt_service.dart';
import '../../../../core/services/user_preferences.dart';
import '../../../../core/usecases/login_use_case.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories interface/auth_repo.dart';

class AuthProvider with ChangeNotifier {
  final LoginUseCase _loginUseCase;
  final AuthRepository _authRepository;
  final JwtService _jwtService = JwtService();

  AuthProvider(this._loginUseCase, this._authRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _error = '';
  String get error => _error;

  User? _user;
  User? get user => _user;

  String? _accessToken;
  String? _refreshToken;

  // Check if the user is already saved (i.e., already logged in)
  Future<void> loadUserFromStorage() async {
    _user = await UserPreferences.getUser();
    _accessToken = await UserPreferences.getAccessToken();
    _refreshToken = await UserPreferences.getRefreshToken();
    notifyListeners();
  }

  // Login method with saving user data and tokens
  Future<void> login(String username, String password) async {
    _isLoading = true;
    notifyListeners();

    try {

      final loggedInUser = await _loginUseCase.execute(username, password);
      _user = loggedInUser;
      _accessToken = loggedInUser.accessToken;
      _refreshToken = loggedInUser.refreshToken;

      await UserPreferences.saveUser(_user!);
      await UserPreferences.saveTokens(_accessToken!, _refreshToken!);

      _error = ''; // Clear any previous error messages
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  // Log out the user
  Future<void> logout() async {
    await UserPreferences.logout();
    _user = null;
    _accessToken = null;
    _refreshToken = null;
    notifyListeners();
  }

  // Validate access token (checks expiry)
  Future<bool> validateAccessToken() async {
    if (_accessToken == null) return false;

    try {
      final payload = _jwtService.parseJwtPayload(_accessToken!);
      final expiryDate = DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);
      return expiryDate.isAfter(DateTime.now());
    } catch (e) {
      return false;
    }
  }

  Future<bool> refreshToken() async {
    if (_refreshToken == null) return false;
    try {
      final success = await _authRepository.refreshSession();
      return success;
    } catch (e) {
      _error = "Token refresh failed: ${e.toString()}";
      notifyListeners();
      return false;
    }
  }

}
