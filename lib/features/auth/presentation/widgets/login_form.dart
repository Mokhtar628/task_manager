import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/validators/form_validator.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../task_manager/presentation/screens/task_page.dart';
import '../provider/auth_provider.dart';
import '../widgets/password_field.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  LoginForm({
    required this.usernameController,
    required this.passwordController,
  });

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  late final FormValidator _formValidator;

  @override
  void initState() {
    super.initState();
    _formValidator = FormValidator();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: widget.usernameController,
            decoration: const InputDecoration(
              labelText: "Username",
              border: OutlineInputBorder(),
            ),
            validator: _formValidator.validateUsername,
          ),
          const SizedBox(height: 10),
          PasswordField(
            controller: widget.passwordController,
            labelText: 'Enter your password',
            validator: _formValidator.validatePassword,
          ),
          const SizedBox(height: 20),
          if (authProvider.isLoading)
            const CircularProgressIndicator()
          else
            CustomButton(
              label: 'Login',
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  authProvider.login(
                    widget.usernameController.text,
                    widget.passwordController.text,
                  ).then((_) {
                    if (authProvider.user != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => TasksPage()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: ${authProvider.error}')),
                      );
                    }
                  });
                }
              },
            ),
          if (authProvider.error.isNotEmpty)
            Text(
              'Error: ${authProvider.error}',
              style: const TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }
}
