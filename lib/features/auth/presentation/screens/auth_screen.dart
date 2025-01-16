import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/features/task_manager/presentation/screens/task_page.dart';
import '../../../../core/widgets/custom_button.dart';
import '../provider/auth_provider.dart';
import '../widgets/login_form.dart';
import '../widgets/password_field.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    authProvider.loadUserFromStorage().then((_) async {
      if (authProvider.user != null) {
        // Validate Access Token
        final isAccessTokenValid = await authProvider.validateAccessToken();

        if (!isAccessTokenValid) {
          // If invalid, try to refresh the token
          final isTokenRefreshed = await authProvider.refreshToken();

          if (!isTokenRefreshed) {
            await authProvider.logout();
            // Token refresh failed, redirect to login
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AuthScreen()),
            );
            return;
          }
        }

        // Navigate to HomeScreen if token is valid
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TasksPage()),
        );
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
        child: LoginForm(
          usernameController: usernameController,
          passwordController: passwordController,
        ),
      ),
    );
  }
}
