import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/services/user_preferences.dart';
import '../models/task_model.dart';

class RemoteTaskDatasource {
  final String baseUrl = 'https://dummyjson.com/todos';

  // Fetch tasks with limit and skip parameters.
  Future<List<TaskModel>> fetchTasks({int limit = 10, int skip = 0}) async {
    final response = await http.get(Uri.parse('$baseUrl?limit=$limit&skip=$skip'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['todos'] as List).map((task) => TaskModel.fromJson(task)).toList();
    } else {
      throw Exception('Failed to fetch tasks');
    }
  }

  Future<TaskModel> addTask(TaskModel task) async {
    final loggedUser = await UserPreferences.getUser();

    if (loggedUser == null) {
      throw Exception('No logged-in user found. Cannot add task.');
    }

    final userId = loggedUser.id;

    print("Sending request to ${Uri.parse('$baseUrl/add')}");
    print("Payload: ${jsonEncode({
      'todo': task.todo,
      'completed': task.completed,
      'userId': userId,
    })}");

    final response = await http.post(
      Uri.parse('$baseUrl/add'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'todo': task.todo,
        'completed': task.completed,
        'userId': userId,
      }),
    );

    print("Response: ${response.statusCode} | ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body);
      return TaskModel.fromJson(data);
    } else {
      throw Exception('Failed to add task. Status: ${response.statusCode}, Response: ${response.body}');
    }
  }



  // Delete a task by simulating a DELETE request to the server.
  Future<TaskModel> deleteTask(int taskId) async {
    final response = await http.delete(Uri.parse('$baseUrl/$taskId'));
    print("Response: ${response.statusCode} | ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return TaskModel.fromJson(data); // Return the task with isDeleted and deletedOn
    } else {
      throw Exception('Failed to delete task');
    }
  }

  // Update a task by simulating a PUT/PATCH request.
  Future<TaskModel> updateTask(TaskModel task) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${task.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'todo': task.todo,
        'completed': task.completed,
      }),
    );

    print("Response: ${response.statusCode} | ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return TaskModel.fromJson(data); // Return the updated task
    } else {
      throw Exception('Failed to update task');
    }
  }
}
