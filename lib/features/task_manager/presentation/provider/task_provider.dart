import 'package:flutter/material.dart';
import '../../domain/entities/task.dart';
import '../../domain/usecases/add_tasks.dart';
import '../../domain/usecases/delete_tasks.dart';
import '../../domain/usecases/get_tasks.dart';
import '../../domain/usecases/update_tasks.dart';


class TaskProvider extends ChangeNotifier {
  final GetTasksUseCase getTasks;
  final AddTaskUseCase addTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;

  TaskProvider({
    required this.getTasks,
    required this.addTaskUseCase,
    required this.deleteTaskUseCase,
    required this.updateTaskUseCase,
  });

  String _selectedFilter = 'all'; // Filter to hold the current filter ('all', 'completed', 'incomplete')
  String get selectedFilter => _selectedFilter; // Expose the selected filter

  List<Task> allTasks = []; // List of all fetched tasks (without any filter)
  List<Task> tasks = []; // List of tasks based on the current filter
  bool isLoading = false;
  int currentSkip = 0; // To track pagination state
  final int limit = 10;

  // Fetch tasks based on the filter and append to `allTasks`
  Future<void> fetchTasks({bool append = false, bool fromUpdate = false}) async {
    if (isLoading || fromUpdate) return; // Skip reloading tasks if coming from an update

    isLoading = true;
    notifyListeners();

    try {
      final newTasks = await getTasks(limit, currentSkip);

      // Add new tasks to allTasks
      if (append) {
        allTasks.addAll(newTasks); // Append new tasks to allTasks
      } else {
        allTasks = newTasks; // Replace with the newly fetched tasks
      }

      currentSkip += limit; // Update skip value

      _filterTasks();

    } catch (e) {
      // Handle error, e.g., show a message
      print("Error fetching tasks: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  void _filterTasks() {
    if (_selectedFilter == 'all') {
      tasks = List.from(allTasks); // Show all tasks
    } else if (_selectedFilter == 'completed') {
      tasks = allTasks.where((task) => task.completed).toList(); // Show only completed tasks
    } else if (_selectedFilter == 'incomplete') {
      tasks = allTasks.where((task) => !task.completed).toList(); // Show only incomplete tasks
    }
    notifyListeners(); // Notify listeners to update tasks list
  }


  // Set status filter and update the displayed tasks
  void setStatusFilter(String? value) {
    _selectedFilter = value!;
    _filterTasks();
    notifyListeners();
  }




  Future<void> addTask(Task task) async {
    await addTaskUseCase.call(task);
    fetchTasks(); // Reload tasks after adding
  }

  Future<void> deleteTask(int taskId) async {
    await deleteTaskUseCase.call(taskId);
    fetchTasks(fromUpdate: true);
  }

  Future<void> updateTask(Task task) async {
    await updateTaskUseCase.call(task);
    fetchTasks(fromUpdate: true);  }
}
