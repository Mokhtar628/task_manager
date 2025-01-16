import 'package:flutter/material.dart';
import 'package:task_manager/features/auth/di/dependency_injection.dart' as auth_di;
import 'package:task_manager/features/task_manager/di/task_manager_di.dart' as task_di;
import 'app.dart';

void main() {
  auth_di.setup();
  task_di.setup();
  runApp(MyApp());
}
