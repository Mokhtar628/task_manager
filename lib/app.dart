import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/features/task_manager/presentation/provider/task_provider.dart';
import 'features/auth/di/dependency_injection.dart';
import 'features/auth/presentation/provider/auth_provider.dart';
import 'features/auth/presentation/screens/auth_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => injector<AuthProvider>(),
        ),
        ChangeNotifierProvider<TaskProvider>(
          create: (context) => injector<TaskProvider>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Manager',
        home: AuthScreen(),  // Your main widget
      ),
    );
  }
}

