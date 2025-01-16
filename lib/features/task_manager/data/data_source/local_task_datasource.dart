import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';

class LocalTaskDatasource {
  Future<List<TaskModel>> getCachedTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksString = prefs.getString('tasks');
    if (tasksString == null) return [];
    final tasks = jsonDecode(tasksString) as List;
    return tasks.map((task) => TaskModel.fromJson(task)).toList();
  }

  Future<void> cacheTasks(List<TaskModel> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('tasks', json.encode(tasks.map((task) => task.toJson()).toList()));
  }
}
